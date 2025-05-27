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
    public partial class PROD_SeguimientoPañol : System.Web.UI.Page
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

                    if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_GERENTES" || group == "DOMINIOW_COMPRAS")
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



        private void TraerCartera(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
           

            try
            {

              
                unosParametros = new SqlParameter[3];

                unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = TextBoxIni.Text;

                if (TextBoxFin.Text != "")
                {
                    DateTime dHasta = Convert.ToDateTime(TextBoxFin.Text, new System.Globalization.CultureInfo("es-ES"));
                    dHasta = dHasta.AddDays(1);
                    unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                    unosParametros[1].Value = dHasta.ToString("dd/MM/yyyy");

                }
                else
                {
                    unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                    unosParametros[1].Value = TextBoxFin.Text;
                }

               

                unosParametros[2] = new SqlParameter("@Tipo", System.Data.SqlDbType.Int);
                unosParametros[2].Value = DropDownList1.SelectedValue;

               

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

        private void ActualizarCumplimiento(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
           


            try
            {
                unAcceso.AbrirConexion();
                unAcceso.EjecutarSentencia_NonQuery((nombreStored));                             

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
      


        protected void ButtonVer_Click(object sender, EventArgs e)
        {
            gwNoCumplidos.Visible = true;
            this.TraerCartera(gwNoCumplidos, "dbo.SP_PROD_SeguimientoInsumos");


            if (gwNoCumplidos.Rows.Count > 0)
            {
                LinkButton2.Visible = true;
            }
            else
            {
                LinkButton2.Visible = false;

            }
        }



        protected void LinkButton2_Click(object sender, EventArgs e)
        {
          

            StringBuilder sb = new StringBuilder();
            StringWriter sw = new StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            Page page = new Page();
            HtmlForm form = new HtmlForm();
            gwNoCumplidos.EnableViewState = false;
            page.EnableEventValidation = false;
            page.DesignerInitialize();
            page.Controls.Add(form);
            form.Controls.Add(gwNoCumplidos);
            page.RenderControl(htw);

            Page.Response.Clear();
            Page.Response.Buffer = true;
            Page.Response.ContentType = "application/vnd.ms-excel";

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= SeguimientoInsumos.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();

           
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            gwNoCumplidos.Visible = true;
            this.TraerCartera(gwNoCumplidos, "dbo.SP_PROD_SeguimientoInsumos");


            if (gwNoCumplidos.Rows.Count > 0)
            {
                LinkButton2.Visible = true;
            }
            else
            {
                LinkButton2.Visible = false;

            }
        }
     

    

    }

       
}
