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
    public partial class VT_CredyCondPagoPorVendedor : System.Web.UI.Page
    {
        
        
        protected void Page_Load(object sender, EventArgs e)
        {

            //if (!IsPostBack)
            //{

                Session["Accede"] = "NO";
                string usuario = Clases.Varias.RemoveSpecialCharacters(Session["usr"].ToString());
                string sUsuario = Request.QueryString["Usuario"];
                 Session["Vendedor"] = Request.QueryString["Parametro"];


                if (usuario == sUsuario || usuario == "DOMINIOjcianfagna")
                {
                    Session["Accede"] = "OK";
                }

                else
                {
                    IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                    foreach (IdentityReference i in irc)
                    {
                        string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                        if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_DIRECCION")
                        {

                            Session["Accede"] = "OK";


                        }

                    }
                }
                if (Session["Accede"].ToString() == "NO")
                {
                    Response.Redirect("Restringida.aspx");

                }
                else
                {

                    this.TraerDetalle("dbo.SP_VT_TraerCredyTipoPagoXV");
                    lblTitulo.Text = Session["Vendedor"].ToString();
                }


                       
        }       
       
   
        private void TraerDetalle(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;

            try
            {


                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Vendedor", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["Vendedor"].ToString().Trim();

               
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

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= CredyTipoPago.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
        }
        

       
    }
}