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
    public partial class VT_VentasPorFamilia : System.Web.UI.Page
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
                    this.TraerVentas("dbo.SP_TraerVentasPorFamiliaXV");
                    this.TraerVentas2("dbo.SP_TraerVentasPorClienteKilosXV");
                    this.TraerDetalleVentas("dbo.SP_TraerDetalleVentasKilosXV");
                    Label1.Text = Session["Vendedor"].ToString();
                }


                       
        }


       
        private void TraerVentas(string nombreStored)
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
               


                Chart4.DataSource = unDS;
                Chart4.Series["Series1"].XValueMember = "Familia";
                Chart4.Series["Series1"].YValueMembers = "Kilos";
               
                Chart4.DataBind();

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerVentas2(string nombreStored)
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



                Chart1.DataSource = unDS;
                Chart1.Series["Series1"].XValueMember = "Cliente";
                Chart1.Series["Series1"].YValueMembers = "Kilos";

                Chart1.DataBind();

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
        private void TraerVentasPorFamilia(string nombreStored, string Familia)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
           
            try
            {


                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@Vendedor", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["Vendedor"].ToString().Trim();
              
                unosParametros[1] = new SqlParameter("@Familia", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = Familia;

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

        private void TraerVentasKilosPorCliente(string nombreStored, string Cliente)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;

            try
            {


                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@Vendedor", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["Vendedor"].ToString().Trim();

                unosParametros[1] = new SqlParameter("@Cliente", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = Cliente;

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

        private void TraerDetalleVentas(string nombreStored)
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

        protected void Chart4_Click(object sender, ImageMapEventArgs e)
        {

            string sFamilia = e.PostBackValue.ToString();
            lblTitulo.Text = "Familia: " + sFamilia;
            this.TraerVentasPorFamilia("dbo.SP_TraerDetalleVentasPorFamiliaXV", sFamilia);
               

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

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= VentasPorCliente.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
        }

        protected void Chart1_Click(object sender, ImageMapEventArgs e)
        {
            string sCliente = e.PostBackValue.ToString();
            lblTitulo.Text = "Cliente: " + sCliente;
            this.TraerVentasKilosPorCliente("dbo.SP_TraerDetalleVentasPorClienteKilosXV", sCliente);
        }
        

       
    }
}