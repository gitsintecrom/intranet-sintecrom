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
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;




namespace SintecromNet.Paginas
{
    public partial class DIR_DetallePedidos : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Accede"] = "NO";


            IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
            foreach (IdentityReference i in irc)
            {
                string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_DIRECCION" || group == "DOMINIOW_GERENTES")
                {

                    Session["Accede"] = "OK";


                }

            }
            if (Session["Accede"].ToString() == "NO")
            {
                Response.Redirect("Restringida.aspx");

            }

            if (Session["Rango"].ToString() == "Mensual")
            {
                lblTitulo.Text = " Mes " + DateTime.Now.Month + "/" + DateTime.Now.Year;
                this.TraerDetallePedidosM("dbo.SP_I_TableroPedidosDetalleM");
                this.TraerPedidosPorFamiliaKilosM("dbo.SP_I_TableroPedidosDetalleFamiliaM");
                this.TraerPedidosPorVendedorM("dbo.SP_I_TableroPedidosDetalleVendedorM");
                gwGrilla.Visible = true;
            }
            else
            {
                lblTitulo.Text =  DateTime.Now.ToShortDateString();
                this.TraerDetallePedidos("dbo.SP_I_TableroPedidosDetalle");
                this.TraerPedidosPorFamiliaKilos("dbo.SP_I_TableroPedidosDetalleFamiliaDolares");
                this.TraerPedidosPorVendedor("dbo.SP_I_TableroPedidosDetalleVendedor");
                gwGrilla.Visible = true;

            }            
          
            
        }

        private void TraerPedidosPorFamiliaKilos(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;



            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = DateTime.Today.ToString("yyyyMMdd");

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);




                //Cargo el Chart con la lista de los usuarios con rol
                Chart4.DataSource = unDS;
                Chart4.Series["Series1"].XValueMember = "Familia";
                Chart4.Series["Series1"].YValueMembers = "Kilos";

                Chart4.DataBind();

                Chart1.DataSource = unDS;
                Chart1.Series["Series1"].XValueMember = "Familia";
                Chart1.Series["Series1"].YValueMembers = "TOTAL_IMPORTE";

                Chart1.DataBind();


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerPedidosPorFamiliaKilosM(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));




                //Cargo el Chart con la lista de los usuarios con rol
                Chart4.DataSource = unDS;
                Chart4.Series["Series1"].XValueMember = "Familia";
                Chart4.Series["Series1"].YValueMembers = "Kilos";

                Chart4.DataBind();

                Chart1.DataSource = unDS;
                Chart1.Series["Series1"].XValueMember = "Familia";
                Chart1.Series["Series1"].YValueMembers = "TOTAL_IMPORTE";

                Chart1.DataBind();


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerPedidosPorVendedor(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = DateTime.Today.ToString("yyyyMMdd");



                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);



                //Cargo el Chart con la lista de los usuarios con rol
                Chart2.DataSource = unDS;
                Chart2.Series["Series1"].XValueMember = "Vendedor";
                Chart2.Series["Series1"].YValueMembers = "TOTAL_IMPORTE";

                Chart2.DataBind();


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerPedidosPorVendedorM(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
            DataSet unDS = null;

            try
            {


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));




                //Cargo el Chart con la lista de los usuarios con rol
                Chart2.DataSource = unDS;
                Chart2.Series["Series1"].XValueMember = "Vendedor";
                Chart2.Series["Series1"].YValueMembers = "TOTAL_IMPORTE";

                Chart2.DataBind();


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerDetallePedidosM(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
            DataSet unDS = null;

            try
            {
               

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));


                gwGrilla.DataSource = unDS;
                gwGrilla.DataBind();




            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }



        private void TraerDetallePedidos(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
           
           

            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = DateTime.Today.ToString("yyyyMMdd");
            

                
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

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= Pedidos.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
            gwGrilla.Visible = false;
        }
          

       
    }
}