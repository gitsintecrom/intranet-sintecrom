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
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using System.Net;
using System.Text;
using System.Web.UI.HtmlControls;


namespace SintecromNet.Paginas
{
    public partial class DIR_DetalleFacturacionPorMes : System.Web.UI.Page
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


            //lblTitulo.Text = " Mes " + DateTime.Now.Month + "/" + DateTime.Now.Year;
            lblTitulo.Text = " Mes " + Session["Periodo"].ToString();



            this.TraerDetalleFacturacion("dbo.SP_DIR_TableroFacturacionDetalleAnual");
            gwGrilla.Visible = true;

            this.TraerFacturacionPorFamilia("dbo.SP_DIR_TableroFacturacionDetalleFamiliaAnual");

            this.TraerFacturacionPorFamiliaKilos("dbo.SP_DIR_TableroFacturacionDetalleFamiliaAnual");

            this.TraerFacturacionPorVendedor("dbo.SP_DIR_TableroFacturacionDetalleVendedorAnual");
            
        }


        private void TraerFacturacionPorFamilia(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            string FechaInicial = "";
            string FechaFinal = "";
           
            

            try
            {
               
                //    DateTime dPrimerDia = DateTime.Today;
                //    DateTime Desde = new DateTime(dPrimerDia.Year, dPrimerDia.Month, 1);
                //    FechaInicial = Desde.ToString("dd/MM/yyy");
                
                //FechaFinal = DateTime.Today.ToString("dd/MM/yyy"); 
                FechaInicial = "01/" + Session["Periodo"].ToString();
                if (Session["Periodo"].ToString().Substring(0, 2) == "12")
                {
                    FechaFinal = "31/" + Session["Periodo"].ToString();
                }

                else
                {
                    DateTime fechatemp = Convert.ToDateTime(FechaInicial);



                    DateTime fecha2 = new DateTime(fechatemp.Year, fechatemp.Month + 1, 1).AddDays(-1);
                    FechaFinal = fecha2.ToString("dd/MM/yyy");
                }

                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = FechaInicial;

                unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = FechaFinal;


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);

                


                //Cargo el Chart con la lista de los usuarios con rol
                Chart1.DataSource = unDS;
                Chart1.Series["Series1"].XValueMember = "Supra_Familia";
                Chart1.Series["Series1"].YValueMembers = "Dolares";
               
                Chart1.DataBind();
               

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerFacturacionPorFamiliaKilos(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            string FechaInicial = "";
            string FechaFinal = "";



            try
            {
                
                //    DateTime dPrimerDia = DateTime.Today;
                //    DateTime Desde = new DateTime(dPrimerDia.Year, dPrimerDia.Month, 1);
                //    FechaInicial = Desde.ToString("dd/MM/yyy");
                
              
                //FechaFinal = DateTime.Today.ToString("dd/MM/yyy");
                FechaInicial = "01/" + Session["Periodo"].ToString();
                if (Session["Periodo"].ToString().Substring(0, 2) == "12")
                {
                    FechaFinal = "31/" + Session["Periodo"].ToString();
                }

                else
                {
                    DateTime fechatemp = Convert.ToDateTime(FechaInicial);



                    DateTime fecha2 = new DateTime(fechatemp.Year, fechatemp.Month + 1, 1).AddDays(-1);
                    FechaFinal = fecha2.ToString("dd/MM/yyy");
                }

                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = FechaInicial;

                unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = FechaFinal;


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);




                //Cargo el Chart con la lista de los usuarios con rol
                Chart4.DataSource = unDS;
                Chart4.Series["Series1"].XValueMember = "Supra_Familia";
                Chart4.Series["Series1"].YValueMembers = "Kilos";

                Chart4.DataBind();


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerDetalleFacturacion(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            string FechaInicial = "";
            string FechaFinal = "";
           

            try
            {

                //DateTime dPrimerDia = DateTime.Today;
                //DateTime Desde = new DateTime(dPrimerDia.Year, dPrimerDia.Month, 1);
                FechaInicial =  "01/" + Session["Periodo"].ToString();

                if(Session["Periodo"].ToString().Substring(0,2) == "12")
                {
                    FechaFinal = "31/" + Session["Periodo"].ToString();
                }

                else
                {
                    DateTime fechatemp = Convert.ToDateTime(FechaInicial);



                    DateTime fecha2 = new DateTime(fechatemp.Year, fechatemp.Month + 1, 1).AddDays(-1);
                    FechaFinal = fecha2.ToString("dd/MM/yyy");
                }

              


            
                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = FechaInicial;

                unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = FechaFinal;

                
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
        private void TraerFacturacionPorVendedor(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            string FechaInicial = "";
            string FechaFinal = "";



            try
            {
                
                //    DateTime dPrimerDia = DateTime.Today;
                //    DateTime Desde = new DateTime(dPrimerDia.Year, dPrimerDia.Month, 1);
                //    FechaInicial = Desde.ToString("dd/MM/yyy");
               
                //FechaFinal = DateTime.Today.ToString("dd/MM/yyy");
                FechaInicial = "01/" + Session["Periodo"].ToString();
                if (Session["Periodo"].ToString().Substring(0, 2) == "12")
                {
                    FechaFinal = "31/" + Session["Periodo"].ToString();
                }

                else
                {
                    DateTime fechatemp = Convert.ToDateTime(FechaInicial);



                    DateTime fecha2 = new DateTime(fechatemp.Year, fechatemp.Month + 1, 1).AddDays(-1);
                    FechaFinal = fecha2.ToString("dd/MM/yyy");
                }

                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = FechaInicial;

                unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = FechaFinal;


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);




                //Cargo el Chart con la lista de los usuarios con rol
                Chart2.DataSource = unDS;
                Chart2.Series["Series1"].XValueMember = "Vendedor";
                Chart2.Series["Series1"].YValueMembers = "Dolares";

                Chart2.DataBind();


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        protected void Button2_Click1(object sender, EventArgs e)
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

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= Facturacion.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
        }

     

       
    }
}