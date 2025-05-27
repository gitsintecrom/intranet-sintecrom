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
    public partial class VT_CuentaCorrientePorVendedor : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
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
                    this.TraerVencimientos("dbo.SP_VT_TraerVencimientosXV");
                    this.TraerCtaCte("dbo.SP_VT_TraerCtaCtePorClienteXV");
                    this.TraerResumen("dbo.SP_VT_TraerResumenCtaCteXV");
                    this.TraerDetalle("dbo.SP_VT_TraerDetalleCtaCteXV");

                    Label1.Text = Session["Vendedor"].ToString();
                }


            }        
        }

       

      

      
       
        private void TraerVencimientos(string nombreStored)
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
                Chart4.Series["Series1"].XValueMember = "Tipo";
                Chart4.Series["Series1"].YValueMembers = "Total";
               
                Chart4.DataBind();

              




            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerVencimientosTorta(string nombreStored)
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
                unosParametros[1].Value = Session["Cliente"].ToString().Trim();

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);



                Chart4.DataSource = unDS;
                Chart4.Series["Series1"].XValueMember = "Tipo";
                Chart4.Series["Series1"].YValueMembers = "Total";

                Chart4.DataBind();


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerCtaCte(string nombreStored)
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


                gwGrilla0.DataSource = unDS;

                gwGrilla0.DataBind();             
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerResumenPorCliente(string nombreStored)
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
                unosParametros[1].Value = Session["Cliente"].ToString().Trim();

               


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

        private void TraerResumen(string nombreStored)
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



                GridView1.DataSource = unDS;

                GridView1.DataBind();
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerDetallePorCliente(string nombreStored)
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
                unosParametros[1].Value = Session["Cliente"].ToString().Trim();




                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);



                GridView1.DataSource = unDS;

                GridView1.DataBind();
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

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= ResumenCtaCtePorCliente.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
        }

        protected void gwGrilla0_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {

                int index = Convert.ToInt32(e.CommandArgument);



                Session["NomCliente"] = this.gwGrilla0.DataKeys[index].Values[0].ToString();
                Session["Cliente"] = this.gwGrilla0.DataKeys[index].Values[1].ToString();
                Session["Cliente_ID"] = this.gwGrilla0.DataKeys[index].Values[2].ToString();

               

            }
        }

        protected void gwGrilla0_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.TraerVencimientosTorta("SP_VT_TraerCtaCtePorClienteTortaXV");
            this.TraerResumenPorCliente("SP_VT_TraerResumenClienteCtaCteXV");
            this.TraerDetallePorCliente("SP_VT_TraerDetalleClienteCtaCteXV");
            lblTitulo.Text = Session["NomCliente"].ToString();
            Label2.Text = Session["NomCliente"].ToString();

        }

        protected void gwGrilla0_RowDataBound(object sender, GridViewRowEventArgs e)
        {
           

        }

        protected void ImgExcel2_Click(object sender, ImageClickEventArgs e)
        {
            StringBuilder sb = new StringBuilder();
            StringWriter sw = new StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            Page page = new Page();
            HtmlForm form = new HtmlForm();

            GridView1.EnableViewState = false;
            page.EnableEventValidation = false;
            page.DesignerInitialize();
            page.Controls.Add(form);
            form.Controls.Add(GridView1);
            page.RenderControl(htw);

            Page.Response.Clear();
            Page.Response.Buffer = true;
            Page.Response.ContentType = "application/vnd.ms-excel";

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= DetalleCtaCtePorCliente.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
        }

        protected void gwGrilla_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);

            Session["ID_Cliente"] = this.gwGrilla.DataKeys[index].Values[0].ToString();



            Panel2.Visible = true;
            gwGrilla.Visible = false;
            btnExcel.Visible = false;
            Label4.Text = this.gwGrilla.DataKeys[index].Values[1].ToString();
            this.TraerValores("SP_TraerResumenCtaCteClientes");
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

        protected void Button1_Click(object sender, EventArgs e)
        {
            Panel2.Visible = false;
            gwGrilla.Visible = true;
            //this.TraerVencimientos("dbo.SP_VT_TraerVencimientosXV");
            //this.TraerCtaCte("dbo.SP_VT_TraerCtaCtePorClienteXV");
            //this.TraerResumen("dbo.SP_VT_TraerResumenCtaCteXV");
            //this.TraerDetalle("dbo.SP_VT_TraerDetalleCtaCteXV");
        }

       

       
    }
}