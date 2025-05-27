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
    public partial class MAIL_GeneracionMailMasivo : System.Web.UI.Page
    {
        DataSet unDS0 = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Sector"] = Request.QueryString["Parametro"];

           
            if (!IsPostBack)
            {               
                
                IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;

                foreach (IdentityReference i in irc)
                {
                    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                    if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES") || group == ("DOMINIOW_MAILMASIVO"))
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
                    CargarCombo();
                    TraerComunicacion();
                }

            }
        }

        private void CargarCombo()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_MAIL_TraerComboVendedores"));

                ddComboVendedor.DataSource = unDS;
                ddComboVendedor.DataValueField = "OPERADORASOCIADODEFAULT_ID";
                ddComboVendedor.DataTextField = "Descripcion";
                ddComboVendedor.DataBind();
                ddComboVendedor.Items.Insert(0, new ListItem("Todos", ""));

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerEmails()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;

         
            try
            {
                unosParametros = new SqlParameter[1];
                unosParametros[0] = new SqlParameter("@Operador", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = ddComboVendedor.SelectedValue;  

                unAcceso.AbrirConexion();
                unDS0 = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_MAIL_TraerEmails"), unosParametros);
              

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerComunicacion()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;

            try
            {
              

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_MAIL_TraerComunicacion"));

                Session["Comu"] = Convert.ToInt32(unDS.Tables[0].Rows[0]["comu"].ToString());

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        protected void btnEjecutar_Click(object sender, EventArgs e)
        {

            this.TraerEmails();
            //Response.Write("<script>window.confirm('La Transacción ha Sido Ingresada Exitosamente');</script>");
            //LimpiarCampos();
            DataTable dt = unDS0.Tables[0];

            foreach (DataRow row in dt.Rows)
            {

                string sMail = Convert.ToString(row["mail"]);
                string sNombre = Convert.ToString(row["nombre"]);
                this.InsertarDatos("dbo.SP_Mail_InsertarMailsMasivos", sMail, sNombre);
               
            }
            elegidos.Visible = true;
            this.TraerGrilla("SP_MAIL_TraerMailsaEnviar");
           
         
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            LimpiarCampos();           
        }

        private void TraerGrilla(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;

            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Campa", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt32(Session["Comu"]);

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

        private void EliminarDatos(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[2];



                unosParametros[0] = new SqlParameter("@Comu", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt32(Session["Comu"]);

                unosParametros[1] = new SqlParameter("@Vend", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = Session["Vend"].ToString();               



                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

        private void ModificarDatos(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[1];



                unosParametros[0] = new SqlParameter("@Comu", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt32(Session["Comu"]);

               



                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

        private void DescartarDatos(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[1];



                unosParametros[0] = new SqlParameter("@Comu", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt32(Session["Comu"]);





                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }



        private void InsertarDatos(string nombreSP, string mail, string nombre)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[7];



                unosParametros[0] = new SqlParameter("@Comunicacion", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt32(Session["Comu"]);                

                unosParametros[1] = new SqlParameter("@Destinatarios", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = mail;

                unosParametros[2] = new SqlParameter("@Sector", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = Session["Sector"].ToString();

                unosParametros[3] = new SqlParameter("@Cabecera", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = txtAsunto.Text;

                unosParametros[4] = new SqlParameter("@Cuerpo", System.Data.SqlDbType.VarChar);
                unosParametros[4].Value = txtMensaje.Text;

                unosParametros[5] = new SqlParameter("@Vendedor", System.Data.SqlDbType.VarChar);
                unosParametros[5].Value = ddComboVendedor.SelectedItem.Text;

                unosParametros[6] = new SqlParameter("@Nombre", System.Data.SqlDbType.VarChar);
                unosParametros[6].Value = nombre;



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
            ddComboVendedor.SelectedValue = "";
            txtAsunto.Text = "";
            txtMensaje.Text = "";

        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            this.ModificarDatos("SP_MAIL_EnviarComunicacion");
            Response.Redirect("..//ContentPage.aspx");
        }

        protected void gwGrilla_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                //Session["Comu"] = this.gwGrilla.DataKeys[index].Values[0].ToString();
                Session["Vend"] = this.gwGrilla.DataKeys[index].Values[1].ToString();

                this.EliminarDatos("SP_MAIL_EliminarComunicacion");
                this.TraerGrilla("SP_MAIL_TraerMailsaEnviar");
                
             

            }
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            this.DescartarDatos("SP_MAIL_DescartarComunicacion");
            Response.Redirect("..//ContentPage.aspx");
        }

      
    

      

       
    }

       
}
