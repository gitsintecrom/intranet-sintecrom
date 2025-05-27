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
    public partial class ADM_ChequesEnCartera : System.Web.UI.Page
    {
        
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

            this.ConsolidoChequesEnCartera("dbo.SP_I_TraerValores");
            this.TraerChequesCartera("dbo.SP_TraerChequesFechaVencimiento");
            this.Traer_SaldoCartera("SP_I_TableroChequesEnCartera");
            this.TraerTodosLosCheques("dbo.SP_TraerTodosLosCheques");
            gwGrilla.Visible = true;
           
        }



        private void Traer_SaldoCartera(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));

                Decimal dSaldoCartera = (Convert.ToDecimal(unDS.Tables[0].Rows[0]["CHEQUES_EN_CARTERA"]));
                lblSaldoChequesCartera.Text = "Total:" + " " + dSaldoCartera.ToString("###,###,##0.#0");



            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerTodosLosCheques(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
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

      

        private void TraerDetalleCheques(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
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
        private void TraerChequesCartera(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;

            try
            {


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));


                Chart4.DataSource = unDS;
                Chart4.Series["Series1"].XValueMember = "Titulo";
                Chart4.Series["Series1"].YValueMembers = "Importe";
               
                Chart4.DataBind();


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
        private void ConsolidoChequesEnCartera(string nombreSP)
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
            if (e.PostBackValue.ToString() == "En Fecha")
            {
                lblTitulo.Text = "En Fecha";
                this.TraerDetalleCheques("dbo.SP_TraerChequesEnFecha");
                gwGrilla.Visible = true;

            }
            if (e.PostBackValue.ToString() == "15 Días")
            {
                lblTitulo.Text = "15 Días";
                this.TraerDetalleCheques("dbo.SP_TraerChequesQuince");
                gwGrilla.Visible = true;


            }
            if (e.PostBackValue.ToString() == "30 Días")
            {
                lblTitulo.Text = "30 Días";
                this.TraerDetalleCheques("dbo.SP_TraerChequesTreinta");
                gwGrilla.Visible = true;


            }
            if (e.PostBackValue.ToString() == "45 Días")
            {
                lblTitulo.Text = "45 Días";
                this.TraerDetalleCheques("dbo.SP_TraerChequesCuarenta");
                gwGrilla.Visible = true;


            }
            if (e.PostBackValue.ToString() == "Más de 45 Días")
            {
                lblTitulo.Text = "Más de 45 Días";
                this.TraerDetalleCheques("dbo.SP_TraerChequesMas");
                gwGrilla.Visible = true;


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

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= ChequesEnCartera.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
        }

       
    }
}