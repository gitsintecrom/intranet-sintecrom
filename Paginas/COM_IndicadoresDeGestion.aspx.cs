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
    public partial class COM_IndicadoresDeGestion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
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
            else
            {
                //this.ConsolidoRequerimientos("dbo.SP_I_Control_Requerimientos_Insumos");
                this.TraerDetalle("dbo.SP_RequerimientosInsumosDetallePorSector", "");
                this.RequerimientosPorSector("dbo.SP_RequerimientosInsumosPorSector");
                this.RequerimientosPorProveedor("dbo.SP_RequerimientosPorProveedor");
            }

        }
        private void TraerDetalle(string nombreStored, string sSector)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;


            try
            {

                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@Sector", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = sSector;

                unosParametros[1] = new SqlParameter("@Cumplido", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = DropDownList1.SelectedValue;

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);


                gwGrilla.DataSource = unDS;
                gwGrilla.DataBind();


                gwoc.DataSource = unDS;
                gwoc.DataBind();




            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
        private void RequerimientosPorSector(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;

            try
            {
                unosParametros = new SqlParameter[1];

              
                unosParametros[0] = new SqlParameter("@Cumplido", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = DropDownList1.SelectedValue;
                
                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);

                Chart4.DataSource = unDS;
                Chart4.Series["Series1"].XValueMember = "Sector";
                Chart4.Series["Series1"].YValueMembers = "Cantidad";

                Chart4.DataBind();
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
             

                unosParametros[0] = new SqlParameter("@Proveedor", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = proveedor;

                unosParametros[1] = new SqlParameter("@Cumplido", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = DropDownList1.SelectedValue;
               
                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);


                gwGrilla.DataSource = unDS;
                gwGrilla.DataBind();

                gwoc.DataSource = unDS;
                gwoc.DataBind();
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }


        private void RequerimientosPorProveedor(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;

            DataSet unDS = null;

            try
            {
                unosParametros = new SqlParameter[1];



                unosParametros[0] = new SqlParameter("@Cumplido", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = DropDownList1.SelectedValue;

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);

                Chart1.DataSource = unDS;
                Chart1.Series["Series1"].XValueMember = "Proveedor";
                Chart1.Series["Series1"].YValueMembers = "Cantidad";

                Chart1.DataBind();


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
       

        protected void Chart4_Click(object sender, ImageMapEventArgs e)
        {
            string sSector = e.PostBackValue;
            lblTitulo.Text = sSector;
            Label1.Text = sSector;
            this.TraerDetalle("dbo.SP_RequerimientosInsumosDetallePorSector", sSector); 
            
        }

        protected void Chart1_Click(object sender, ImageMapEventArgs e)
        {
            
            string sProveedor = e.PostBackValue;
            lblTitulo.Text = sProveedor;
            Label1.Text = sProveedor;
            this.TraerDetalleProveedor("dbo.SP_RequerimientosDetallePorProveedor", sProveedor); 
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

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= Requerimientos.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
        }

        protected void ImageButton1_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            StringBuilder sb = new StringBuilder();
            StringWriter sw = new StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            Page page = new Page();
            HtmlForm form = new HtmlForm();

            gwoc.EnableViewState = false;
            page.EnableEventValidation = false;
            page.DesignerInitialize();
            page.Controls.Add(form);
            form.Controls.Add(gwoc);
            page.RenderControl(htw);

            Page.Response.Clear();
            Page.Response.Buffer = true;
            Page.Response.ContentType = "application/vnd.ms-excel";

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= OC.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            this.TraerDetalle("dbo.SP_RequerimientosInsumosDetallePorSector", "");
            this.RequerimientosPorSector("dbo.SP_RequerimientosInsumosPorSector");
            this.RequerimientosPorProveedor("dbo.SP_RequerimientosPorProveedor");
        }
    }
}