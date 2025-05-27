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
using System.Drawing;

using Microsoft.Reporting.WebForms;
using System.IO;
using System.Drawing.Imaging;
using System.Net;
using System.Text;
using System.Web.UI.HtmlControls;


namespace SintecromNet.Paginas
{
    public partial class SC_ParcialesHornoSRP : System.Web.UI.Page
    {        
            
                   
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Accede"] = "NO";           
           

            IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
            foreach (IdentityReference i in irc)
            {
                string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_SUPPLYCHAIN" || group == "DOMINIOW_DIRECCION" || group == "DOMINIOW_ADMINISTRACION" || group == "DOMINIOW_VENTAS")
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
                this.TraerGrilla("dbo.SP_TraerOperacionesParcialesHorno");
            }
        }   
       


        protected void Button2_Click1(object sender, EventArgs e)
        {




        }

      
        private void TraerGrilla(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("RegistracionNET");
            DataSet unDS = null;
                   

            try
            {


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));

                gwGrilla.DataSource = unDS;
                gwGrilla.DataBind();

                 

                DataTable dt = unDS.Tables[0].Copy();
                if (dt.Rows.Count > 0) btnExcel.Visible = true;

                Session["Tabla"] = dt;

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

         
       

        protected void btnExcel_Click(object sender, ImageClickEventArgs e)
        {
            //string nombre = "ParcialesHorno";
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

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= OperacionesPendientesdePesada.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();



        }

    

       
    }
}