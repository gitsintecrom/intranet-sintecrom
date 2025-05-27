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
    public partial class VT_ConfiguracionListaDePrecios : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["Accede"] = "NO";


                IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                foreach (IdentityReference i in irc)
                {
                    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                    if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES") || group == ("DOMINIOW_AUTORIZACION_COMERCIAL"))
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
                    this.LimpiarCampos();
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
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@NumeroLista", System.Data.SqlDbType.Int);
                unosParametros[0].Value = txtNumero.Text;

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);



                DataTable dt = unDS.Tables[0].Copy();
                if (dt.Rows.Count > 0)
                {
                    Mensaje.Visible = true;
                    lblLista.Text = txtNumero.Text;
                    lblVigencia.Text = TextBoxIni.Text;
                    lblVersion.Text = txtVersion.Text;
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

        private void GeneraLista(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS1 = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS1 = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));             

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void RegeneraLista(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS1 = null;
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Lista", System.Data.SqlDbType.Int);
                unosParametros[0].Value = txtNumero.Text;

                unAcceso.AbrirConexion();
                unDS1 = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);

               

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerLista(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@NumeroLista", System.Data.SqlDbType.Int);
                unosParametros[0].Value = txtNumero.Text;

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);

                

                DataTable dt = unDS.Tables[0].Copy();
                if (dt.Rows.Count > 0)
                {
                    Div1.Visible = true;
                    this.RegeneraLista("SP_VT_RegenerarListaPrecios");




                }
                else
                {
                    this.GeneraLista("SP_VT_GenerarListaPrecios");
                    this.EditarDatos("SP_VT_EditarListaPreciosNueva");

                    this.TraerGrilla(gwGrilla, "SP_VT_TraerListaPrecios");

                }

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerListaParaEditar(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@NumeroLista", System.Data.SqlDbType.Int);
                unosParametros[0].Value = txtBuscaLista.Text;

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);



                DataTable dt = unDS.Tables[0].Copy();
                if (dt.Rows.Count > 0)
                {

                    Div2.Visible = false;
                    btnAceptar.Visible = false;
                    btnEditar.Visible = true;
                    
                    txtNumero.Text =    dt.Rows[0]["NumeroLista"].ToString();

                    txtVersion.Text =   dt.Rows[0]["version"].ToString();
                    TextBoxIni.Text =   dt.Rows[0]["Vigencia"].ToString();
                    


                }
                else
                {
                    Label3.Visible = true;
                    Label3.Text = "La Lista seleccionada no existe, Reintente !!!";


                }

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }



        private void EditarDatos(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[4];



                unosParametros[0] = new SqlParameter("@NumeroLista", System.Data.SqlDbType.Int);
                unosParametros[0].Value = txtNumero.Text.Trim();

                unosParametros[1] = new SqlParameter("@Vigencia", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = TextBoxIni.Text;

                unosParametros[2] = new SqlParameter("@Version", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = txtVersion.Text.Trim();

                unosParametros[3] = new SqlParameter("@Estado", System.Data.SqlDbType.Int);
                unosParametros[3].Value = ddHabilita.SelectedValue;



                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
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

        protected void btnModifica_click(object sender, EventArgs e)
        {
            this.EditarDatos("dbo.SP_VT_EditarListaPrecios");
            this.TraerGrilla(gwGrilla, "SP_VT_TraerListaPrecios");
            Div1.Visible = false;
        }

        protected void btnCancela_click(object sender, EventArgs e)
        {
            Div1.Visible = false;
        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            Mensaje.Visible = false;
            this.TraerLista("dbo.SP_VT_TraerListaPrecios");
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Div2.Visible = true;
            Label3.Visible = false;
            Mensaje.Visible = false;
        }

        protected void Button1_click(object sender, EventArgs e)
        {
            this.TraerListaParaEditar("dbo.SP_VT_TraerListaPrecios");
        }

        protected void Button2_click(object sender, EventArgs e)
        {
            this.LimpiarCampos();

        }

        protected void LimpiarCampos()
        {
            Mensaje.Visible = false; 
            Div2.Visible = false;
            Label3.Visible = false;
            txtNumero.Text = "0";
            TextBoxIni.Text = "";
            txtVersion.Text = "";
            btnEditar.Visible = false;
            btnAceptar.Visible = true;
        }



        protected void btnEditar_Click(object sender, EventArgs e)
        {
            this.RegeneraLista("SP_VT_RegenerarListaPrecios");
            this.EditarDatos("dbo.SP_VT_EditarListaPrecios");
            this.TraerGrilla(gwGrilla, "SP_VT_TraerListaPrecios");
        }
    }

       
}
