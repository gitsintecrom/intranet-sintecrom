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
    public partial class COM_MateriasPrimasPendientes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
            Session["Accede"] = "NO";


            IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
            foreach (IdentityReference i in irc)
            {
                string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_GERENTES" || group == "DOMINIOW_COMPRAS"
                    || group == "DOMINIOW_VENTAS" || group == "DOMINIOW_SUPPLYCHAIN" || group == ("DOMINIOW_VENDEDORES"))
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
                this.ConsolidoPendientes("dbo.SP_I_TraerOCPendientes");
                this.TraerDetalle("dbo.SP_TraerOCPendientes");
                this.TraerPendientePorFecha("dbo.SP_TraerOCPendientesPorFechaTotal");
                this.TraerPendientePorFamilia("dbo.SP_COM_TraerOCPendientesPorFamiliaEspesor");
                this.TraerPendientePorProveedor("dbo.SP_TraerOCPendientesPorProveedorTotal");
            }

        }
        private void TraerDetalle(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;


            try
            {

                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@FechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = "";

                unosParametros[1] = new SqlParameter("@Proveedor", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = "";
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

        private void TraerDetallePorFamilia(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;


            try
            {

                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@Familia", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["Familia"].ToString().Trim();

                unosParametros[1] = new SqlParameter("@Espesor", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = Session["Espesor"].ToString().Trim();

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

        private void TraerDetalleDia(string nombreStored, string Fecha)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;

            try
            {

                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@FechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Fecha;

                unosParametros[1] = new SqlParameter("@Proveedor", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = "";

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

        private void TraerDetalleProveedor(string nombreStored, string proveedor)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
          
            try
            {
                
                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@FechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = "";

                unosParametros[1] = new SqlParameter("@Proveedor", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = proveedor;
               
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
        private void TraerPendientePorFecha(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;

            try
            {


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));


                Chart4.DataSource = unDS;
                Chart4.Series["Series1"].XValueMember = "FechaEntrega";
                Chart4.Series["Series1"].YValueMembers = "Kilos";

                Chart4.DataBind();


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerPendientePorFamilia(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;

            try
            {


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));



                GridView1.DataSource = unDS;
                GridView1.DataBind();


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerPendientePorProveedor(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;

            try
            {


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));


                Chart1.DataSource = unDS;
                Chart1.Series["Series1"].XValueMember = "Proveedor";
                Chart1.Series["Series1"].YValueMembers = "Kilos";

                Chart1.DataBind();


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
        private void ConsolidoPendientes(string nombreSP)
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

        protected void Chart4_Click(object sender, ImageMapEventArgs e)
        {
            string sFecha = e.PostBackValue;
            lblTitulo.Text = sFecha;
            sFecha = Convert.ToDateTime(sFecha).ToString("yyyyMMdd");
            this.TraerDetalleDia("dbo.SP_TraerOCPendientes", sFecha); 
            
        }

        protected void Chart1_Click(object sender, ImageMapEventArgs e)
        {
            
            string sProveedor = e.PostBackValue;
            lblTitulo.Text = sProveedor;
            this.TraerDetalleProveedor("dbo.SP_TraerOCPendientes", sProveedor); 
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

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= MPPendientes.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
            gwGrilla.Visible = false;
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Ver")
            {

                int index = Convert.ToInt32(e.CommandArgument);

               
                Session["Familia"] = this.GridView1.Rows[index].Cells[1].Text.ToString();
                Session["Espesor"] = this.GridView1.Rows[index].Cells[2].Text.ToString();
                


                this.TraerDetallePorFamilia("SP_COM_TraerDetalleOCPendientesPorFamiliaEspesor");
              


            }
        }
    }
}