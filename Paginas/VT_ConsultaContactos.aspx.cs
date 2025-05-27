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
    public partial class VT_ConsultaContactos : System.Web.UI.Page
    {
       

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //Session["Accede"] = "NO";
                //Session["Accion"] = "";
                //Session["Planta"] = "";


                //IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                //foreach (IdentityReference i in irc)
                //{
                //    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                //    if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES") )
                //    {
                //        Session["Accede"] = "OK";
                //    }

                //}
                //if (Session["Accede"].ToString() == "NO")
                //{
                //    Response.Redirect("Restringida.aspx");
                //}
                //else
                //{
                    
                //}
                this.TraerGrilla(gwGrilla, "SP_TraerPotencialesClientes");

              
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


      


     

    }

       
}
