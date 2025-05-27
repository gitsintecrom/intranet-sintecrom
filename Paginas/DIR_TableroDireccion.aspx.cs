using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Collections;
using System.Data;
using System.DirectoryServices;
using System.DirectoryServices.ActiveDirectory;
using System.Security.Principal;





namespace SintecromNet.Paginas
{
    public partial class DIR_TableroDireccion : System.Web.UI.Page
    {
        string sFecha = DateTime.Today.ToString("dd/MM/yyy");
        protected void Page_Load(object sender, EventArgs e)
        {            
            if (!IsPostBack)
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
                else
                {
                    Session["Rango"] = "";
                    lblDia.Text = sFecha.ToString();
                    Label7.Text = sFecha.ToString();
                    this.Traer_SaldoCartera("SP_I_TableroChequesEnCartera");
                    this.Consolido_Cobranzas("dbo.SP_I_Consolida_Cobranzas_Diarias");
                    this.TraerCobranzas("dbo.SP_Traer_Totales");
                    this.ConsolidoFacturacion("Calipso.SP_I_FacturacionTablero");
                    this.TraerFacturacion("SP_TableroFacturacionD");
                    this.TraerNotaCredito("SP_TableroNotaCreditoD");
                    this.TraerNotaDebito("SP_TableroNotaDebitoD");
                    this.TraerPedidos("SP_TableroDireccionPedidosD");
                    //Mensual
                    this.TraerAcumulado("dbo.SP_Acumulado_Mensual");
                    this.TraerFacturacionMensual("SP_TableroFacturacionD");
                    this.TraerNotaCreditoMensual("SP_TableroNotaCreditoD");
                    this.TraerNotaDebitoMensual("SP_TableroNotaDebitoD");
                    this.TraerPedidosM("SP_TableroDireccionPedidosM");
                    //Anual
                    this.TraerFacturacionAnual("SP_TraerFacturacionTableroAnual");

                }
            }
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

        private void TraerFacturacionAnual(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;

            try
            {
                

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));



                Chart1.DataSource = unDS;
                Chart1.Series["Series1"].XValueMember = "Mes";
                Chart1.Series["Series1"].YValueMembers = "Importe";

                Chart1.DataBind();

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
           
            decimal diasel = 0;
            decimal promediorango = 0;

            try
            {
            
                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = sFecha;

                unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = sFecha;


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);




                for (int i = 0; i < unDS.Tables[0].Rows.Count; i++)
                {

                    acumulado = acumulado + Convert.ToDecimal(unDS.Tables[0].Rows[i]["Importe"].ToString());
                    diasel = diasel + 1;

                }
                
                
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

        private void ConsolidoFacturacion(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            DateTime dPrimerDia = DateTime.Today;
            DateTime Desde = new DateTime(dPrimerDia.Year, dPrimerDia.Month, 1);
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

        private void TraerFacturacion(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            decimal PesosDiarios = 0;
            decimal DolaresDiarios = 0;
            decimal KilosDiarios = 0;

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
                    KilosDiarios = Convert.ToDecimal(unDS.Tables[0].Rows[0]["Kilos"].ToString());


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

        private void TraerFacturacionMensual(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            decimal PesosDiarios = 0;
            decimal DolaresDiarios = 0;
            decimal KilosDiarios = 0;
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
                    KilosDiarios = Convert.ToDecimal(unDS.Tables[0].Rows[0]["Kilos"].ToString());


                    //lblKilos.Text = String.Format("{0:c}", KilosDiarios);
                    lblFacturacionPM.Text = String.Format("{0:c}", PesosDiarios);
                    lblFacturacionDM.Text = String.Format("{0:c}", DolaresDiarios);
                }

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerNotaCredito(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
           
            decimal PesosCreditos = 0;
            decimal DolaresCreditos = 0;

            try
            {

                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = sFecha;

                unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = sFecha;


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);

                DataTable dt = unDS.Tables[0].Copy();
                if (unDS.Tables[0].Rows[0]["CredPesos"].ToString() != "")
                {
                    PesosCreditos = Convert.ToDecimal(unDS.Tables[0].Rows[0]["CredPesos"].ToString());
                    DolaresCreditos = Convert.ToDecimal(unDS.Tables[0].Rows[0]["CredDolares"].ToString());
                    lblCreditosP.Text = String.Format("{0:c}", PesosCreditos);
                    lblCreditosD.Text = String.Format("{0:c}", DolaresCreditos);
                }
                else
                {
                    lblCreditosP.Text = "0";
                    lblCreditosD.Text = "0";
                }

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerNotaCreditoMensual(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            DateTime dPrimerDia = DateTime.Today;
            DateTime Desde = new DateTime(dPrimerDia.Year, dPrimerDia.Month, 1);
            string sDesde = Desde.ToString("dd/MM/yyy");

            decimal PesosCreditos = 0;
            decimal DolaresCreditos = 0;

            try
            {

                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = sDesde;

                unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = sFecha;


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);

                DataTable dt = unDS.Tables[0].Copy();
                if (unDS.Tables[0].Rows[0]["CredPesos"].ToString() != "")
                {
                    PesosCreditos = Convert.ToDecimal(unDS.Tables[0].Rows[0]["CredPesos"].ToString());
                    DolaresCreditos = Convert.ToDecimal(unDS.Tables[0].Rows[0]["CredDolares"].ToString());
                    lblCreditosPM.Text = String.Format("{0:c}", PesosCreditos);
                    lblCreditosDM.Text = String.Format("{0:c}", DolaresCreditos);
                }
                else
                {
                    lblCreditosPM.Text = "0";
                    lblCreditosDM.Text = "0";
                }

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
        private void TraerNotaDebito(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            decimal PesosDebitos = 0;
            decimal DolaresDebitos = 0;            

            try
            {

                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = sFecha;

                unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = sFecha;


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);

                DataTable dt = unDS.Tables[0].Copy();
                if (unDS.Tables[0].Rows[0]["DebPesos"].ToString() != "")
                {
                    PesosDebitos = Convert.ToDecimal(unDS.Tables[0].Rows[0]["DebPesos"].ToString());
                    DolaresDebitos = Convert.ToDecimal(unDS.Tables[0].Rows[0]["DebDolares"].ToString());                 


                    lblDebitosP.Text = String.Format("{0:c}", PesosDebitos);
                    lblDebitosD.Text = String.Format("{0:c}", DolaresDebitos);
                }
                else
                {
                    lblDebitosP.Text = "0";
                    lblDebitosD.Text = "0";
                }
               

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerNotaDebitoMensual(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            decimal PesosDebitos = 0;
            decimal DolaresDebitos = 0;
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

                DataTable dt = unDS.Tables[0].Copy();
                if (unDS.Tables[0].Rows[0]["DebPesos"].ToString() != "")
                {
                    PesosDebitos = Convert.ToDecimal(unDS.Tables[0].Rows[0]["DebPesos"].ToString());
                    DolaresDebitos = Convert.ToDecimal(unDS.Tables[0].Rows[0]["DebDolares"].ToString());


                    lblDebitosPM.Text = String.Format("{0:c}", PesosDebitos);
                    lblDebitosDM.Text = String.Format("{0:c}", DolaresDebitos);
                }
                else
                {
                    lblDebitosPM.Text = "0";
                    lblDebitosDM.Text = "0";
                }


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerPedidos(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            decimal PedidosDolares = 0;

            try
            {

                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = DateTime.Today.ToString("yyyyMMdd");

                
                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);

                if (unDS.Tables[0].Rows[0]["TOTAL_IMPORTE"].ToString() != "")
                {
                    PedidosDolares = Convert.ToDecimal(unDS.Tables[0].Rows[0]["TOTAL_IMPORTE"].ToString());


                    lblPedidosDolares.Text = String.Format("{0:c}", PedidosDolares);
                    lblPedidosKilos.Text = (Convert.ToInt32(unDS.Tables[0].Rows[0]["CANTIDAD_CANTIDAD"])).ToString();
                }
                else
                {
                    lblPedidosDolares.Text = "0";
                    lblPedidosKilos.Text = "0";
                }


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerPedidosM(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
            DataSet unDS = null;
            decimal PedidosDolares = 0;

            try
            {

               


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));

                if (unDS.Tables[0].Rows[0]["TOTAL_IMPORTE"].ToString() != "")
                {
                    PedidosDolares = Convert.ToDecimal(unDS.Tables[0].Rows[0]["TOTAL_IMPORTE"].ToString());


                    Label19.Text = String.Format("{0:c}", PedidosDolares);
                    Label15.Text = (Convert.ToInt32(unDS.Tables[0].Rows[0]["CANTIDAD_CANTIDAD"])).ToString();
                }
                else
                {
                    Label15.Text = "0";
                    Label19.Text = "0";
                }


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

                //FechaInicial = this.TextBoxIni.Text;
                //FechaFinal = this.TextBoxFin.Text;

                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = FechaInicial;

                unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = FechaFinal;


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);




             
                for (int i = 0; i < unDS.Tables[0].Rows.Count; i++)
                {

                    acumulado = acumulado + Convert.ToDecimal(unDS.Tables[0].Rows[i]["Importe"].ToString());
                    diasel = diasel + 1;

                }
                //lblPromediol0.Visible = true;
                //lblPromedioMesA.Visible = true;
                //lblTexto0.Visible = true;
                //lblAcumuladoMesA.Visible = true;
                //lblAcumuladoMesA.Text = String.Format("{0:c}", acumulado); //acumulado.ToString();

                if (diasel > 0)
                {
                    promediom = acumulado / diasel;
                }
                else
                {
                    promediom = 0;
                }
                //lblPromedioMesA.Text = String.Format("{0:c}", promediom);


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


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));

                for (int i = 0; i < unDS.Tables[0].Rows.Count; i++)
                {

                    acumulado = acumulado + Convert.ToDecimal(unDS.Tables[0].Rows[i]["Importe"].ToString());
                    diasel = diasel + 1;

                }

                if(acumulado > 0)
                {
                     decimal promediom = acumulado / diasel;

                lblAcumuladoM.Text = String.Format("{0:c}", acumulado); //acumulado.ToString();
                lblPromedio.Text = String.Format("{0:c}", promediom);
                }
                else
                {
                    lblAcumuladoM.Text = "0";
                    lblPromedio.Text = "0";
                }




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

            try
            {

                //FechaInicial = this.TextBoxIni.Text;
                //FechaFinal = this.TextBoxFin.Text;


                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = FechaInicial;

                unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = FechaFinal;


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);




                for (int i = 0; i < unDS.Tables[0].Rows.Count; i++)
                {

                    acumulado = acumulado + Convert.ToDecimal(unDS.Tables[0].Rows[i]["Importe"].ToString());
                    diasel = diasel + 1;

                }
                //lblTexto1.Visible = true;
                //lblAcumuladoAno.Visible = true;
                //lblPromediol1.Visible = true;
                //lblPromedioAnoA.Visible = true;
                //lblAcumuladoAno.Text = String.Format("{0:c}", acumulado); //acumulado.ToString();
                //if (diasel > 0)
                //{
                //    promedioano = acumulado / diasel;
                //}
                //lblPromedioAnoA.Text = String.Format("{0:c}", promedioano);


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
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

        protected void btnRefrescar_Click(object sender, EventArgs e)
        {
            //this.Traer_SaldoCartera("SP_I_TableroChequesEnCartera");
            //this.Consolido_Cobranzas("dbo.SP_I_Consolida_Cobranzas_Diarias");
            //this.TraerCobranzas("dbo.SP_Traer_Totales");
            //this.ConsolidoFacturacion("Calipso.SP_I_FacturacionTablero");
            //this.TraerFacturacion("SP_TableroFacturacionD");
            //this.TraerNotaCredito("SP_TableroNotaCreditoD");
            //this.TraerNotaDebito("SP_TableroNotaDebitoD");
            //this.TraerPedidos("SP_TableroDireccionPedidosD");
            ////Anual
            //this.TraerFacturacionAnual("SP_TraerFacturacionTableroAnual");


            Session["Rango"] = "";
            lblDia.Text = sFecha.ToString();
            Label7.Text = sFecha.ToString();
            this.Traer_SaldoCartera("SP_I_TableroChequesEnCartera");
            this.Consolido_Cobranzas("dbo.SP_I_Consolida_Cobranzas_Diarias");
            this.TraerCobranzas("dbo.SP_Traer_Totales");
            this.ConsolidoFacturacion("Calipso.SP_I_FacturacionTablero");
            this.TraerFacturacion("SP_TableroFacturacionD");
            this.TraerNotaCredito("SP_TableroNotaCreditoD");
            this.TraerNotaDebito("SP_TableroNotaDebitoD");
            this.TraerPedidos("SP_TableroDireccionPedidosD");
            //Mensual
            this.TraerAcumulado("dbo.SP_Acumulado_Mensual");
            this.TraerFacturacionMensual("SP_TableroFacturacionD");
            this.TraerNotaCreditoMensual("SP_TableroNotaCreditoD");
            this.TraerNotaDebitoMensual("SP_TableroNotaDebitoD");
            this.TraerPedidosM("SP_TableroDireccionPedidosM");

            //Anual
            this.TraerFacturacionAnual("SP_TraerFacturacionTableroAnual");

           
        }

     
        protected void Timer1_Tick(object sender, EventArgs e)
        {
            this.Traer_SaldoCartera("SP_I_TableroChequesEnCartera");
            this.Consolido_Cobranzas("dbo.SP_I_Consolida_Cobranzas_Diarias");
            this.TraerCobranzas("dbo.SP_Traer_Totales");
            this.ConsolidoFacturacion("Calipso.SP_I_FacturacionTablero");
            this.TraerFacturacion("SP_TableroFacturacionD");
            this.TraerNotaCredito("SP_TableroNotaCreditoD");
            this.TraerNotaDebito("SP_TableroNotaDebitoD");
            this.TraerPedidos("SP_TableroDireccionPedidosD");
            //Anual
            this.TraerFacturacionAnual("SP_TraerFacturacionTableroAnual");

        }

        protected void btnCheques_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Paginas/ADM_ChequesEnCartera.aspx");
        }

        protected void btnCobranzas_Click(object sender, EventArgs e)
        {
            Session["Rango"] = "Diario";
            Response.Redirect("/Paginas/DIR_DetalleCobranzas.aspx");

        }

        protected void btnFacturacion_Click(object sender, EventArgs e)
        {

            Session["Rango"] = "Diario";
            Response.Redirect("/Paginas/DIR_DetalleFacturacion.aspx");
        }

        protected void btnDebCred_Click(object sender, EventArgs e)
        {
            Session["Rango"] = "Diario";
            Response.Redirect("/Paginas/DIR_DetalleNC.aspx");
        }

        protected void btnDebitos_Click(object sender, EventArgs e)
        {
            Session["Rango"] = "Diario";
            Response.Redirect("/Paginas/DIR_DetalleND.aspx");
        }

        protected void btnPedidos_Click(object sender, EventArgs e)
        {
            Session["Rango"] = "Diario";
            Response.Redirect("/Paginas/DIR_DetallePedidos.aspx");
        }

        protected void btnCobranzasM_Click(object sender, EventArgs e)
        {
            Session["Rango"] = "Mensual";
            Response.Redirect("/Paginas/DIR_DetalleCobranzas.aspx");
        }

        protected void btnFacturacionM_Click(object sender, EventArgs e)
        {
            Session["Rango"] = "Mensual";
            Response.Redirect("/Paginas/DIR_DetalleFacturacion.aspx");
        }

        protected void btnDebitosM_Click(object sender, EventArgs e)
        {
            Session["Rango"] = "Mensual";
            Response.Redirect("/Paginas/DIR_DetalleND.aspx");
        }

        protected void btnCreditosM_Click(object sender, EventArgs e)
        {
            Session["Rango"] = "Mensual";
            Response.Redirect("/Paginas/DIR_DetalleNC.aspx");
        }

        protected void btnFacturacionAnual_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Paginas/DIR_DetalleFacturacionAnual.aspx");

        }

        protected void Chart1_Click(object sender, ImageMapEventArgs e)
        {
            Session["Periodo"] =  e.PostBackValue;
            Response.Redirect("/Paginas/DIR_DetalleFacturacionPorMes.aspx");

        }

        protected void btnPedidosM_Click(object sender, EventArgs e)
        {
            Session["Rango"] = "Mensual";
            Response.Redirect("/Paginas/DIR_DetallePedidos.aspx");
        }

      
             
    }
}