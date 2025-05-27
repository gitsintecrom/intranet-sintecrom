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
    public partial class INV_ProgresoInventario : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            this.TraerPendientesPorKilos("SP_INV_InventarioAnualProgresoK");
            this.TraerPendientesPorCantidades("SP_INV_InventarioAnualProgresoC");                                
        }

       
        private void TraerPendientesPorKilos(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;

            try
            {
                
                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));
               


                Chart4.DataSource = unDS;
                Chart4.Series["Series1"].XValueMember = "Estado";
                Chart4.Series["Series1"].YValueMembers = "Kilos";
               
                Chart4.DataBind();


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

     

        private void TraerPendientesPorCantidades(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
           
            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));

                Chart1.DataSource = unDS;
                Chart1.Series["Series1"].XValueMember = "Estado";
                Chart1.Series["Series1"].YValueMembers = "Cantidad";

                Chart1.DataBind();
       
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }


     
        private void TraerDetalle(string nombreStored)
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


        protected void Chart4_Click(object sender, ImageMapEventArgs e)
        {
            Panel1.Visible = true;
            string sEstado = e.PostBackValue;
            Label2.Text = sEstado;
            if (sEstado.ToString() == "Ingresado")
            {
                this.TraerDetalle("SP_INV_EtiquetasInventario");
            }
            else
            {
                this.TraerDetalle("SP_INV_PendienteInventario");

            }
        }

        protected void Chart1_Click(object sender, ImageMapEventArgs e)
        {
            Panel1.Visible = true;
            string sEstado = e.PostBackValue;
            Label2.Text = sEstado;
            if(sEstado.ToString() == "Ingresado")
            {
                this.TraerDetalle("SP_INV_EtiquetasInventario");
            }
            else
            {
                this.TraerDetalle("SP_INV_PendienteInventario");
            }

        }

        protected void LinkButton2_Click(object sender, EventArgs e)
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

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= EstadoInventario.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
        }

       

       
    }
}