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
    public partial class VT_ListaDePreciosXV : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Vendedor"] = Request.QueryString["Parametro"];
            if (!IsPostBack)
            {
                Session["Accede"] = "NO";


                IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                foreach (IdentityReference i in irc)
                {
                    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                    if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES") || group == ("DOMINIOW_VENDEDORES") || group == ("DOMINIOW_AUTORIZACION_COMERCIAL"))
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
                    
                    CargarComboFamilia();
                    CargarComboEspesor();                   
                    CargarComboForma();


                }
               
            }
        
        }

      

        private void TraerGrilla(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;         
            

            try
            {
                unosParametros = new SqlParameter[5];

                unosParametros[0] = new SqlParameter("@Cliente", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = txtCliente.Text;

                unosParametros[1] = new SqlParameter("@Familia", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value =ddFamilia.SelectedValue;

                unosParametros[2] = new SqlParameter("@Espesor", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = ddEspesor.SelectedValue;               

                unosParametros[3] = new SqlParameter("@Forma", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = ddForma.SelectedValue;


                unosParametros[4] = new SqlParameter("@Vendedor", System.Data.SqlDbType.VarChar);
                if ((Session["Vendedor"] == null))
                {
                    unosParametros[4].Value = "";
                }
                else
                {
                    unosParametros[4].Value = Session["Vendedor"].ToString();
                }
                



                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);

                DataTable dt = unDS.Tables[0].Copy();
                if (dt.Rows.Count > 0)
                {
                    Mensaje.Visible = true;
                    lblLista.Text = dt.Rows[0]["NumeroLista"].ToString();
                    lblVigencia.Text = dt.Rows[0]["Vigencia"].ToString();
                    lblVersion.Text = dt.Rows[0]["version"].ToString();

                   
                    unGrid.DataSource = unDS;

                    unGrid.DataBind();


                }
                else
                {
                    Mensaje.Visible = false;

                }

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void CargarComboFamilia()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_VT_TraerComboFamilia"));

                ddFamilia.DataSource = unDS;
                ddFamilia.DataValueField = "Codigo";
                ddFamilia.DataTextField = "Descripcion";
                ddFamilia.DataBind();
                ddFamilia.Items.Insert(0, new ListItem("Seleccione...", ""));

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void CargarComboEspesor()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_VT_TraerComboEspesor"));

                ddEspesor.DataSource = unDS;
                ddEspesor.DataValueField = "Codigo";
                ddEspesor.DataTextField = "Descripcion";
                ddEspesor.DataBind();
                ddEspesor.Items.Insert(0, new ListItem("Seleccione...", ""));

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

      

     

        private void CargarComboForma()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_VT_TraerComboForma"));

                ddForma.DataSource = unDS;
                ddForma.DataValueField = "Codigo";
                ddForma.DataTextField = "Descripcion";
                ddForma.DataBind();
                ddForma.Items.Insert(0, new ListItem("Seleccione...", ""));

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }



      

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            

            
            this.TraerGrilla(gwGrilla, "dbo.SP_VT_TraerListadePrecios");


            //if (gwGrilla.Rows.Count > 0)
            //{
            //    Mensaje.Visible = true;
            //}
            //else
            //{
            //    Mensaje.Visible = false;
            //}
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
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

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= ListaPrecios.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
            //gwGrilla.Visible = false;
        }
    }

       
}
