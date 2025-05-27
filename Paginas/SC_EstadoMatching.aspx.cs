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
    public partial class SC_EstadoMatching : System.Web.UI.Page
    {
       

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {


                this.TraerGrilla(gwGrilla, "SP_SC_EstadoMatching");

              
            }
        
        }

      

        private void TraerGrilla(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            //SqlParameter[] unosParametros = null;

            try
            {
         

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));
                

                unGrid.DataSource = unDS;

                unGrid.DataBind();
              

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            this.TraerGrilla(gwGrilla, "SP_SC_EstadoMatching");

        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            this.TraerGrilla(gwGrilla, "SP_SC_EstadoMatching");
        }

     
       


      


     

    }

       
}
