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
using  System.Web.UI.HtmlControls;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;





namespace SintecromNet.Paginas
{
    public partial class ADM_CostosReposicion : System.Web.UI.Page
    {
       

        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Accede"] = "NO";


            IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
            foreach (IdentityReference i in irc)
            {
                string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_GERENTES")
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
                this.TraerGrilla(gwGrilla, "dbo.SP_COSTOS_TraerCostoReposicion");
             
            }
        
        }

      

        private void TraerGrilla(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
          
            

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

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= FactLS.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
            gwGrilla.Visible = false;
        }  
   
       

        protected void gwGrilla_SelectedIndexChanged(object sender, EventArgs e)
        {
                       
        }

        protected void gwGrilla_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //e.Row.Attributes.Add("onMouseOver", "this.style.background='#f2d9d9';this.style.cursor='pointer'");

                //e.Row.Attributes.Add("onMouseOut", "this.style.background='#ffffff'");


                //e.Row.Attributes["onClick"] = ClientScript.GetPostBackClientHyperlink(this.gwGrilla, "Select$" + e.Row.RowIndex);
                //e.Row.ToolTip = "Haga Click en el Numero de Reclamo para Visualizar el Detalle.";

            }
        }

        protected void Button2_Click1(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            LinkButton2.Visible = true;
          
        }


        protected void Button2_Click(object sender, EventArgs e)
        {
           
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

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= CostosReposicion.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
            gwGrilla.Visible = false;
            LinkButton2.Visible = false;
        }

        protected void Button5_Click(object sender, EventArgs e)
        {
            gwGrilla.Visible = true;
            LinkButton2.Visible = true;
            
        }

       

       
     

    }

       
}
