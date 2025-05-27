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
    public partial class ADM_GestionInternos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
            foreach (IdentityReference i in irc)
            {
                string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES") || group == ("DOMINIOW_RECEPCION"))
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

                this.TraerGrilla(gwGrilla, "SP_TraerInternos");


            }
        
        }
      

        protected void btnEjecutar_Click(object sender, EventArgs e)
        {
          
            if(Session["Accion"].ToString() == "A")
            {
                this.InsertarDatos("dbo.SP_InsertarInternos");
                LimpiarCampos();
                Response.Write("<script>window.confirm('El Interno ha Sido Ingresado Exitosamente');</script>");
                this.TraerGrilla(gwGrilla, "SP_TraerInternos");
                
            }

            else
            {
                if (Session["Accion"].ToString() == "M")
                {
                    this.EditarInterno("dbo.SP_EditarInternos");
                    Panel1.Visible = false;
                    this.TraerGrilla(gwGrilla, "SP_TraerInternos");
                }
               
            }
               

           

           
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            LimpiarCampos();
            Panel1.Visible = false;
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

        private void TraerInterno(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;

            DataSet unDS = null;
            //SqlParameter[] unosParametros = null;

            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@ID", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt32(Session["ID"]);

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);

                txtNombre.Text = (unDS.Tables[0].Rows[0]["Nombre"]).ToString();
                txtInterno.Text = (unDS.Tables[0].Rows[0]["Interno"]).ToString();
                txtSector.Text = (unDS.Tables[0].Rows[0]["Sector"]).ToString();



            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void InsertarDatos(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[3];

                
                unosParametros[0] = new SqlParameter("@Nombre", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = txtNombre.Text.Trim();
                                
                unosParametros[1] = new SqlParameter("@Interno", System.Data.SqlDbType.Int);
                unosParametros[1].Value = txtInterno.Text.Trim();

                unosParametros[2] = new SqlParameter("@Sector", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = txtSector.Text.Trim();

              
                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

        private void EditarInterno(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[4];

                unosParametros[0] = new SqlParameter("@ID", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt32(Session["ID"]);

                unosParametros[1] = new SqlParameter("@Nombre", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = txtNombre.Text.Trim();

                unosParametros[2] = new SqlParameter("@Interno", System.Data.SqlDbType.Int);
                unosParametros[2].Value = Convert.ToInt32(txtInterno.Text);

                unosParametros[3] = new SqlParameter("@Sector", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = txtSector.Text.Trim();
              
                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);


            }
            finally
            {
                unAcceso.CerrarConexion();

            }

        }

        private void EliminarInterno(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@ID", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt32(Session["ID"]);



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
            txtNombre.Text = "";
            txtInterno.Text = "0";
            txtSector.Text = "";
           

        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Session["Accion"] = "A";
            Panel1.Visible = true;
        }

        protected void btnExcel_Click(object sender, ImageClickEventArgs e)
        {
           

            StringBuilder sb = new StringBuilder();
            StringWriter sw = new StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            Page page = new Page();
            HtmlForm form = new HtmlForm();
            gwGrilla.EnableViewState = false;
            page.EnableEventValidation = false;
            page.DesignerInitialize();
            page.Controls.Add(form);
            form.Controls.Add(gwGrilla);
            page.RenderControl(htw);

            Page.Response.Clear();
            Page.Response.Buffer = true;
            Page.Response.ContentType = "application/vnd.ms-excel";

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= ListadoInternos.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();

        }

        protected void gwGrilla_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Editar")
            {


                int index = Convert.ToInt32(e.CommandArgument);
                Panel1.Visible = true;
                Session["ID"] = this.gwGrilla.DataKeys[index].Values[0].ToString();
                Session["Accion"] = "M";
                this.TraerInterno("dbo.SP_TraerInternosID");


            }

            if (e.CommandName == "Eliminar")
            {


                int index = Convert.ToInt32(e.CommandArgument);
                Panel1.Visible = true;
                Session["ID"] = this.gwGrilla.DataKeys[index].Values[0].ToString();
                Session["Accion"] = "B";
                this.EliminarInterno("dbo.SP_EliminarIntenos");
                this.TraerGrilla(gwGrilla, "SP_TraerInternos");

               


            }
        }


       
    }

       
}
