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
using System.Windows.Forms;

namespace SintecromNet.Paginas
{
    public partial class ADM_CredyCondPago : System.Web.UI.Page
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

                    if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_VENTAS" || group == "DOMINIOW_GERENTES" || group == "DOMINIOW_ADMINISTRACION")
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

        protected void ButtonVer_Click(object sender, EventArgs e)
        {
            gwGrilla.Visible = true;
            this.TraerGrilla(gwGrilla, "dbo.SP_ADM_TraerCredyTipoPago");


            if (gwGrilla.Rows.Count > 0)
            {
                btnExcel.Visible = true;


            }
            else
            {
                btnExcel.Visible = false;
            }
        }

        private void TraerGrilla(GridView unGrid,  string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;


            try
            {


                unosParametros = new SqlParameter[2];

               

                unosParametros[0] = new SqlParameter("@Vendedor", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = txtVendedor.Text;

                unosParametros[1] = new SqlParameter("@Cliente", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = txtCliente.Text;


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

        protected void gwGrilla_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Cartera")
            {
                int index = Convert.ToInt32(e.CommandArgument);

                Session["ID_Cliente"] = this.gwGrilla.DataKeys[index].Values[0].ToString();



                Panel2.Visible = true;
                gwGrilla.Visible = false;
                btnExcel.Visible = false;
                Label3.Text = this.gwGrilla.DataKeys[index].Values[1].ToString();
                this.TraerValores("SP_TraerResumenCtaCteClientes");
            }
            if (e.CommandName == "Pedidos")
            {
                int index = Convert.ToInt32(e.CommandArgument);

                Session["ID_Cliente"] = this.gwGrilla.DataKeys[index].Values[0].ToString();



                Panel3.Visible = true;
                gwGrilla.Visible = false;
                btnExcel.Visible = false;
                Label5.Text = this.gwGrilla.DataKeys[index].Values[1].ToString();
                this.TraerPedidos("SP_ADM_PedidoPendiente");
            }
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            StringBuilder sb = new StringBuilder();
            StringWriter sw = new StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            Page page = new Page();
            HtmlForm form = new HtmlForm();

            GridView2.EnableViewState = false;
            page.EnableEventValidation = false;
            page.DesignerInitialize();
            page.Controls.Add(form);
            form.Controls.Add(GridView2);
            page.RenderControl(htw);

            Page.Response.Clear();
            Page.Response.Buffer = true;
            Page.Response.ContentType = "application/vnd.ms-excel";

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= EnCartera.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
        }
        private void TraerValores(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNET");
            SqlParameter[] unosParametros = null;

            DataSet unDS1 = null;

            try
            {

                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@ID", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["ID_Cliente"].ToString().Trim();


                unAcceso.AbrirConexion();
                unDS1 = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);



                GridView2.DataSource = unDS1;
                GridView2.DataBind();



            }
            finally
            {
                unAcceso.CerrarConexion();
            }

        }

        private void TraerPedidos(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNET");
            SqlParameter[] unosParametros = null;

            DataSet unDS1 = null;

            try
            {

                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Cliente_id", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["ID_Cliente"].ToString().Trim();


                unAcceso.AbrirConexion();
                unDS1 = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);



                gwPedidos.DataSource = unDS1;
                gwPedidos.DataBind();



            }
            finally
            {
                unAcceso.CerrarConexion();
            }

        }

        

        protected void Button8_Click(object sender, EventArgs e)
        {
            Panel3.Visible = false;
            gwGrilla.Visible = true;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Panel2.Visible = false;
            gwGrilla.Visible = true;
        }

        protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
        {
            StringBuilder sb = new StringBuilder();
            StringWriter sw = new StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            Page page = new Page();
            HtmlForm form = new HtmlForm();

            gwPedidos.EnableViewState = false;
            page.EnableEventValidation = false;
            page.DesignerInitialize();
            page.Controls.Add(form);
            form.Controls.Add(gwPedidos);
            page.RenderControl(htw);

            Page.Response.Clear();
            Page.Response.Buffer = true;
            Page.Response.ContentType = "application/vnd.ms-excel";

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= PedPendientes.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
        }
    }
}