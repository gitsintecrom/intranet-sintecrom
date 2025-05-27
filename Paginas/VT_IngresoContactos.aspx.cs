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
    public partial class VT_IngresoContactos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


        
        }
      

        protected void btnEjecutar_Click(object sender, EventArgs e)
        {
          

           
                this.InsertarDatos("dbo.SP_InsertarContactos");
                LimpiarCampos();
                Response.Write("<script>window.confirm('El Contacto ha Sido Ingresado Exitosamente');</script>");

           

           
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            LimpiarCampos();
        }

        private void InsertarDatos(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[7];

                
                unosParametros[0] = new SqlParameter("@Empresa", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = txtCliente.Text.Trim();
                                
                unosParametros[1] = new SqlParameter("@Contacto", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = txtContacto.Text.Trim();

                unosParametros[2] = new SqlParameter("@Email", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = txtEmail.Text.Trim();

                unosParametros[3] = new SqlParameter("@Telefono", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = txtTelefono.Text.Trim();

                unosParametros[4] = new SqlParameter("@Celular", System.Data.SqlDbType.VarChar);
                unosParametros[4].Value = txtCelular.Text.Trim();

                unosParametros[5] = new SqlParameter("@Direccion", System.Data.SqlDbType.VarChar);
                unosParametros[5].Value = txtDireccion.Text.Trim();

                unosParametros[6] = new SqlParameter("@Observaciones", System.Data.SqlDbType.VarChar);
                unosParametros[6].Value = txtObservaciones.Text.Trim();


                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

        private void LimpiarCampos()
        {
            txtCliente.Text = "";
            txtContacto.Text = "";
            txtEmail.Text = "";
            txtTelefono.Text = "";
            txtCelular.Text = "";
            txtDireccion.Text = "";
            txtObservaciones.Text = "";
          


        }


       
    }

       
}
