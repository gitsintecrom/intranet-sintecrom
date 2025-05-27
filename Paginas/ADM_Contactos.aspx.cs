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
    public partial class ADM_Contactos : System.Web.UI.Page
    {
       

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["Accede"] = "NO";
                Session["Accion"] = "";
              

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
                            
            }
        
        }

        private void ModificarContacto(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;

            try
            {
                unosParametros = new SqlParameter[7];

                unosParametros[0] = new SqlParameter("@ID", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt32(Session["ID"]);

                unosParametros[1] = new SqlParameter("@Empresa", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = txtCliente.Text.Trim();

                unosParametros[2] = new SqlParameter("@Contacto", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = txtContacto0.Text.Trim();

                unosParametros[3] = new SqlParameter("@Email", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = txtEmail.Text.Trim();
                
                unosParametros[4] = new SqlParameter("@Telefono", System.Data.SqlDbType.VarChar);
                unosParametros[4].Value = txtTelefono.Text.Trim();

                unosParametros[5] = new SqlParameter("@Celular", System.Data.SqlDbType.VarChar);
                unosParametros[5].Value = txtCelular.Text.Trim();

                unosParametros[6] = new SqlParameter("@Observaciones", System.Data.SqlDbType.VarChar);
                unosParametros[6].Value = txtObservaciones.Text.Trim();

                
                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);
                              
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void InsertarContacto(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;

            try
            {
                unosParametros = new SqlParameter[6];

                unosParametros[0] = new SqlParameter("@Empresa", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = txtCliente.Text.Trim();

                unosParametros[1] = new SqlParameter("@Contacto", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = txtContacto0.Text.Trim();

                unosParametros[2] = new SqlParameter("@Email", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = txtEmail.Text.Trim();

                unosParametros[3] = new SqlParameter("@Telefono", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = txtTelefono.Text.Trim();

                unosParametros[4] = new SqlParameter("@Celular", System.Data.SqlDbType.VarChar);
                unosParametros[4].Value = txtCelular.Text.Trim();

                unosParametros[5] = new SqlParameter("@Observaciones", System.Data.SqlDbType.VarChar);
                unosParametros[5].Value = txtObservaciones.Text.Trim();


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void EliminarContacto(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;

            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@ID", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt32(Session["ID"]);


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerGrilla(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;

            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Empresa", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = txtEmpresa.Text;
                               

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);
                

                unGrid.DataSource = unDS;

                unGrid.DataBind();
              

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

     
        protected void btnExcel_Click(object sender, ImageClickEventArgs e)
        {
            //string nombre = "PendientesPesada" + DateTime.Now.ToShortDateString();
            //DataTable tabla = (DataTable)(Session["Tabla"]);

            //Clases.Varias.ExportToSpreadsheet(tabla, nombre);
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

            Page.Response.AddHeader("Content-Disposition", "attachment; filename=Contactos.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
        }

     

        protected void gwGrilla_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {

                int index = Convert.ToInt32(e.CommandArgument);


                Session["ID"] = this.gwGrilla.DataKeys[index].Values[0].ToString();
                Response.Write("<script>window.confirm('Esta Seguro de Eliminar el Contacto?');</script>");
                this.EliminarContacto("SP_ADM_EliminarContactos");
                this.TraerGrilla(gwGrilla, "SP_ADM_TraerContactos");

            }

            if (e.CommandName == "Modificar")
            {

                int index = Convert.ToInt32(e.CommandArgument);


                Session["ID"] = this.gwGrilla.DataKeys[index].Values[0].ToString();
                Panel1.Visible = true;
                txtCliente.Text = this.gwGrilla.DataKeys[index].Values[1].ToString();
                txtContacto0.Text = this.gwGrilla.DataKeys[index].Values[2].ToString();
                txtEmail.Text = this.gwGrilla.DataKeys[index].Values[3].ToString();
                txtTelefono.Text = this.gwGrilla.DataKeys[index].Values[4].ToString();
                txtCelular.Text = this.gwGrilla.DataKeys[index].Values[5].ToString();
                txtObservaciones.Text = this.gwGrilla.DataKeys[index].Values[6].ToString();
                Session["Accion"] = "M";
                
                

            }
        }

        protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
        {

            this.TraerGrilla(gwGrilla, "SP_ADM_TraerContactos");
            Panel1.Visible = false;
            gwGrilla.Visible = true;
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            Panel1.Visible = true;
            Session["Accion"] = "A";
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Panel1.Visible = false;
            this.TraerGrilla(gwGrilla, "SP_ADM_TraerContactos");
        }

        protected void btnEjecutar_Click(object sender, EventArgs e)
        {
            if (Session["Accion"].ToString() == "M")
            {
                this.ModificarContacto("SP_ADM_ModificarContactos");
                Response.Write("<script>window.confirm('El Contacto se ha Sido Modificado Exitosamente');</script>");
                Panel1.Visible = false;
                this.TraerGrilla(gwGrilla, "SP_ADM_TraerContactos");
            }
            if (Session["Accion"].ToString() == "A")
            {
                this.InsertarContacto("SP_ADM_InsertarContactos");
                Response.Write("<script>window.confirm('El Contacto se ha Sido Ingresado Exitosamente');</script>");
                Panel1.Visible = false;
                //this.TraerGrilla(gwGrilla, "SP_ADM_TraerContactos");
            }
            
        }     


      


     

    }

       
}
