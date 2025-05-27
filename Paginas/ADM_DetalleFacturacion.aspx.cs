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
    public partial class ADM_DetalleFacturacion : System.Web.UI.Page
    {
        string sFecha = DateTime.Today.ToString("dd/MM/yyy");
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Accede"] = "NO";


            IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
            foreach (IdentityReference i in irc)
            {
                string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_DIRECCION" || group == "DOMINIOW_ADMINISTRACION")
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
                this.ConsolidoFacturacion("Calipso.SP_I_FacturacionTablero");
                this.TraerFacturacionDiaria("SP_FacturacionAdm");
                this.TraerFacturacionMensual("SP_FacturacionAdm");
                lblDia.Text = sFecha.ToString();

            }

           
        
            
        }

        private void ConsolidoFacturacion(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            //DateTime dPrimerDia = DateTime.Today;
            DateTime Desde = DateTime.Now.AddDays(-180);
           //DateTime Desde = new DateTime(dPrimerDia.Year, dPrimerDia.Month, 1);
            string sDesde = Desde.ToString("yyyyMMdd");

            try
            {

                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                //unosParametros[0].Value = DateTime.Today.ToString("yyyyMMdd");
                unosParametros[0].Value = sDesde;

                unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = DateTime.Today.ToString("yyyyMMdd");


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerFacturacionDiaria(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            decimal PesosDiarios = 0;
            decimal DolaresDiarios = 0;

            try
            {

                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = sFecha;

                unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = sFecha;


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);


                if (unDS.Tables[0].Rows[0]["Pesos"].ToString() != "")
                {
                    PesosDiarios = Convert.ToDecimal(unDS.Tables[0].Rows[0]["Pesos"].ToString());
                    DolaresDiarios = Convert.ToDecimal(unDS.Tables[0].Rows[0]["Dolares"].ToString());


                    //lblKilos.Text = String.Format("{0:c}", KilosDiarios);
                    lblFacturacionP.Text = String.Format("{0:c}", PesosDiarios);
                    lblFacturacionD.Text = String.Format("{0:c}", DolaresDiarios);
                }

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerFacturacionRango(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            decimal PesosDiarios = 0;
            decimal DolaresDiarios = 0;

            try
            {

                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = TextBoxIni.Text;

                unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = TextBoxFin.Text;


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);


                if (unDS.Tables[0].Rows[0]["Pesos"].ToString() != "")
                {
                    PesosDiarios = Convert.ToDecimal(unDS.Tables[0].Rows[0]["Pesos"].ToString());
                    DolaresDiarios = Convert.ToDecimal(unDS.Tables[0].Rows[0]["Dolares"].ToString());


                    //lblKilos.Text = String.Format("{0:c}", KilosDiarios);
                    Label8.Text = String.Format("{0:c}", PesosDiarios);
                    Label10.Text = String.Format("{0:c}", DolaresDiarios);
                   
                }

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerFacturacionMensual(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            decimal PesosDiarios = 0;
            decimal DolaresDiarios = 0;
            DateTime dPrimerDia = DateTime.Today;
            DateTime Desde = new DateTime(dPrimerDia.Year, dPrimerDia.Month, 1);
            string sDesde = Desde.ToString("dd/MM/yyy");

            try
            {

                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = sDesde;

                unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = sFecha;


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);


                if (unDS.Tables[0].Rows[0]["Pesos"].ToString() != "")
                {
                    PesosDiarios = Convert.ToDecimal(unDS.Tables[0].Rows[0]["Pesos"].ToString());
                    DolaresDiarios = Convert.ToDecimal(unDS.Tables[0].Rows[0]["Dolares"].ToString());


                    lblFacturacionAcP.Text = String.Format("{0:c}", PesosDiarios);
                    lblFacturacionAcD.Text = String.Format("{0:c}", DolaresDiarios);
                }

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
               
                //FechaInicial = this.TextBoxIni.Text;
                //FechaFinal = this.TextBoxFin.Text;

                try
                {
                    if (TextBoxIni.Text.Trim() != "")
                    {
                        FechaInicial = this.TextBoxIni.Text;
                    //    Convert.ToDateTime(FechaInicial);
                    //    FechaInicial = FechaInicial.Substring(6, 4) + FechaInicial.Substring(3, 2) + FechaInicial.Substring(0, 2);
                    }
                }
                catch (Exception)
                {
                    //this.LabelErr.Text = "La Fecha Inicial no es válida";
                    //HiddenFieldError_ModalPopupExtender.Show();
                    return;
                }

                try
                {
                    if (TextBoxFin.Text.Trim() != "")
                    {
                        FechaFinal = this.TextBoxFin.Text;
                        //Convert.ToDateTime(FechaFinal);
                        //FechaFinal = FechaFinal.Substring(6, 4) + FechaFinal.Substring(3, 2) + FechaFinal.Substring(0, 2);
                    }
                }
                catch (Exception)
                {
                    //this.LabelErr.Text = "La Fecha Final no es válida";
                    //HiddenFieldError_ModalPopupExtender.Show();
                    return;
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
       
        protected void Button2_Click1(object sender, EventArgs e)
        {

        }

        protected void ButtonVer_Click(object sender, EventArgs e)
        {
            this.TraerDetalleFacturacion("dbo.SP_FacturacionAdmDetalle");
            this.TraerFacturacionRango("SP_FacturacionAdm");

            gwGrilla.Visible = true;
            
            
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

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= Facturacion.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
        }

     

       
    }
}