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
    public partial class COM_PerformanceProveedores : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
            Session["Accede"] = "NO";


            IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
            foreach (IdentityReference i in irc)
            {
                string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_GERENTES" || group == "DOMINIOW_COMPRAS" || group == "DOMINIOW_VENTAS" || group == "DOMINIOW_SUPPLYCHAIN")
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
                this.ConsolidoEntregaMP("dbo.SP_I_ControlFechaEntregaMP");
                this.TraerPromedioCumplimiento("dbo.SP_EntregaMPCumplimiento");
                //this.TraerDetalleProveedor("dbo.SP_TraerDetalleEntregaMP", "");
            }

        }
       
       

        private void TraerDetalleProveedor(string nombreStored, string proveedor)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            lblTitulo.Text = proveedor;
          
            try
            {
                
                unosParametros = new SqlParameter[1];

              
                unosParametros[0] = new SqlParameter("@Proveedor", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = proveedor;
               
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
      
        private void TraerPromedioCumplimiento(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;

            try
            {


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));
                gwGrilla0.DataSource = unDS;
                gwGrilla0.DataBind();

               


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }


        private void ConsolidoEntregaMP(string nombreSP)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");

            try
            {
                unAcceso.AbrirConexion();
                unAcceso.EjecutarSentencia_NonQuery(nombreSP);
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

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= Performance.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
            gwGrilla.Visible = false;
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {

            StringBuilder sb = new StringBuilder();
            StringWriter sw = new StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            Page page = new Page();
            HtmlForm form = new HtmlForm();

            gwGrilla0.EnableViewState = false;
            page.EnableEventValidation = false;
            page.DesignerInitialize();
            page.Controls.Add(form);
            form.Controls.Add(gwGrilla0);
            page.RenderControl(htw);

            Page.Response.Clear();
            Page.Response.Buffer = true;
            Page.Response.ContentType = "application/vnd.ms-excel";

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= DemorayCumplimiento.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
            gwGrilla0.Visible = false;
        }

        protected void gwGrilla0_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {

                int index = Convert.ToInt32(e.CommandArgument);


                Session["Proveedor"] = this.gwGrilla0.DataKeys[index].Values[0].ToString();
                this.TraerDetalleProveedor("dbo.SP_TraerDetalleEntregaMP", Session["Proveedor"].ToString().Trim());

               


            }
        }

        protected void gwGrilla0_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void gwGrilla0_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //e.Row.Attributes.Add("onMouseOver", "this.style.background='#f2d9d9';this.style.cursor='pointer'");

                //e.Row.Attributes.Add("onMouseOut", "this.style.background='#ffffff'");


                e.Row.Attributes["onClick"] = ClientScript.GetPostBackClientHyperlink(this.gwGrilla0, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Haga Click en el Proveedor para Visualizar el Detalle";

            }
        }
    }
}