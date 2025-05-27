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
    public partial class DIR_Cobranzas : System.Web.UI.Page
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
            //lblTexto.Visible = false;
            //lblAcumulado.Visible = false;
            //lblTexto0.Visible = false;
            //lblAcumuladoMesA.Visible = false;
            //lblTexto1.Visible = false;
            this.Consolido_Cobranzas("dbo.SP_Consolida_Cobranzas_Diarias");

            this.TraerAcumulado("dbo.SP_Acumulado_Mensual");
        }

        protected void ButtonVer_Click(object sender, EventArgs e)
        {
            this.TraerDetalleCobranzas("dbo.SP_TraerDetalleCobranzas");
            gwGrilla.Visible = true;

            this.TraerCobranzas("dbo.SP_Traer_Totales");
            Chart1.Visible = true;

            this.TraerCobranzasMes("dbo.SP_Traer_Totales_Mes_Anterior");
            Chart2.Visible = true;

            this.TraerCobranzasAno("dbo.SP_Traer_Totales_Ano_Anterior");
            Chart3.Visible = true;

            Panel1.Visible = true;
        }

        private void Consolido_Cobranzas(string nombreSP)
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
        private void TraerAcumulado(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
           
            DataSet unDS = null;
            decimal acumulado = 0;
            decimal diasel = 0;
            decimal promediom = 0;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored) );
               
                for (int i = 0; i < unDS.Tables[0].Rows.Count; i++)
                {

                    acumulado = acumulado + Convert.ToDecimal(unDS.Tables[0].Rows[i]["Importe"].ToString());
                    diasel = diasel + 1;

                }
                if (acumulado  != 0)
                {
                     promediom = acumulado / diasel;

                }
                else
                {
                     promediom = 0;

                }

                lblAcumuladoMes.Text = String.Format("{0:c}", acumulado); //acumulado.ToString();
                lblPromedio.Text = String.Format("{0:c}", promediom);
                



            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerCobranzas(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            decimal acumulado = 0;
            string FechaInicial = "";
            string FechaFinal = "";
            decimal diasel = 0;
            decimal promediorango = 0;

            try
            {
               
                FechaInicial = this.TextBoxIni.Text;
                FechaFinal = this.TextBoxFin.Text;

                try
                {
                    if (FechaInicial.Trim() != "")
                    {
                        Convert.ToDateTime(FechaInicial);
                        FechaInicial = FechaInicial.Substring(6, 4) + FechaInicial.Substring(3, 2) + FechaInicial.Substring(0, 2);
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
                    if (FechaFinal.Trim() != "")
                    {
                        Convert.ToDateTime(FechaFinal);
                        FechaFinal = FechaFinal.Substring(6, 4) + FechaFinal.Substring(3, 2) + FechaFinal.Substring(0, 2);
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

                


                //Cargo el Chart con la lista de los usuarios con rol
                Chart1.DataSource = unDS;
                Chart1.Series["Series1"].XValueMember = "Fecha";
                Chart1.Series["Series1"].YValueMembers = "Importe";
               
                Chart1.DataBind();
                for (int i = 0; i < unDS.Tables[0].Rows.Count; i++)
                {
                      
                    acumulado = acumulado + Convert.ToDecimal( unDS.Tables[0].Rows[i]["Importe"].ToString());
                    diasel = diasel + 1;
                    
                }
                lblTexto.Visible = true;
                lblAcumulado.Visible = true;
                lblAcumulado.Text = String.Format("{0:c}", acumulado); //acumulado.ToString();
                if (diasel > 0)
                {
                    promediorango = acumulado / diasel;
                }
                


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerDetalleCobranzas(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            string FechaInicial = "";
            string FechaFinal = "";
           

            try
            {

                FechaInicial = this.TextBoxIni.Text;
                FechaFinal = this.TextBoxFin.Text;

                try
                {
                    if (FechaInicial.Trim() != "")
                    {
                        Convert.ToDateTime(FechaInicial);
                        FechaInicial = FechaInicial.Substring(6, 4) + FechaInicial.Substring(3, 2) + FechaInicial.Substring(0, 2);
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
                    if (FechaFinal.Trim() != "")
                    {
                        Convert.ToDateTime(FechaFinal);
                        FechaFinal = FechaFinal.Substring(6, 4) + FechaFinal.Substring(3, 2) + FechaFinal.Substring(0, 2);
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
        private void TraerCobranzasMes(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            decimal acumulado = 0;
            string FechaInicial = "";
            string FechaFinal = "";
            decimal diasel = 0;
            decimal promediom = 0;

            try
            {

                FechaInicial = this.TextBoxIni.Text;
                FechaFinal = this.TextBoxFin.Text;

                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = FechaInicial;

                unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = FechaFinal;


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);




                //Cargo el Chart con la lista de los usuarios con rol
                Chart2.DataSource = unDS;
                Chart2.Series["Series1"].XValueMember = "Fecha";
                Chart2.Series["Series1"].YValueMembers = "Importe";

                Chart2.DataBind();
                for (int i = 0; i < unDS.Tables[0].Rows.Count; i++)
                {

                    acumulado = acumulado + Convert.ToDecimal(unDS.Tables[0].Rows[i]["Importe"].ToString());
                    diasel = diasel + 1;

                }
                lblPromediol0.Visible = true;
                lblPromedioMesA.Visible = true;
                lblTexto0.Visible = true;
                lblAcumuladoMesA.Visible = true;
                lblAcumuladoMesA.Text = String.Format("{0:c}", acumulado); //acumulado.ToString();

                if (diasel > 0)
                {
                     promediom = acumulado / diasel;
                }
                else                
                {
                     promediom = 0;
                }
                lblPromedioMesA.Text = String.Format("{0:c}", promediom);


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerCobranzasAno(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            decimal acumulado = 0;
            string FechaInicial = "";
            string FechaFinal = "";
            decimal diasel = 0;
            decimal promedioano = 0;

            try
            {

                FechaInicial = this.TextBoxIni.Text;
                FechaFinal = this.TextBoxFin.Text;

          
                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = FechaInicial;

                unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = FechaFinal;


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);




                //Cargo el Chart con la lista de los usuarios con rol
                Chart3.DataSource = unDS;
                Chart3.Series["Series1"].XValueMember = "Fecha";
                Chart3.Series["Series1"].YValueMembers = "Importe";

                Chart3.DataBind();
                for (int i = 0; i < unDS.Tables[0].Rows.Count; i++)
                {

                    acumulado = acumulado + Convert.ToDecimal(unDS.Tables[0].Rows[i]["Importe"].ToString());
                    diasel = diasel + 1;

                }
                lblTexto1.Visible = true;
                lblAcumuladoAno.Visible = true;
                lblPromediol1.Visible = true;
                lblPromedioAnoA.Visible = true;
                lblAcumuladoAno.Text = String.Format("{0:c}", acumulado); //acumulado.ToString();
                if (diasel > 0)
                {
                    promedioano = acumulado / diasel;
                }
                lblPromedioAnoA.Text = String.Format("{0:c}", promedioano);


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        protected void Button2_Click1(object sender, EventArgs e)
        {

        }

        protected void btnVerProyectado_Click(object sender, EventArgs e)
        {
            Response.Redirect("Dir_ProyectadoCobranzas.aspx");
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

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= Cobranzas.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
        }
    }
}