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
using System.Net.Mail;






namespace SintecromNet.Paginas
{
    public partial class SIS_TableroSRP : System.Web.UI.Page
    {
       
        protected void Page_Load(object sender, EventArgs e)
        {            
            if (!IsPostBack)
            {

                Session["Accede"] = "NO";


                IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                foreach (IdentityReference i in irc)
                {
                    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                    if (group == "DOMINIOW_SISTEMAS")
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
                    
                    this.Traer_Bloqueos("dbo.SP_SIS_TraerBloqueosMaster");                 
                   

                }


            }
        }
        private void Traer_Bloqueos(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("Master");
            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));


                DataTable dt = unDS.Tables[0].Copy();

                if (dt.Rows.Count > 0)
                {
                    Panel1.Visible = false;
                    lblMensajeBatch.Visible = true;
                    foreach (DataTable table in unDS.Tables)
                    {
                        foreach (DataRow dr in table.Rows)
                        {
                            lblMensajeBatch.Text = "Bloqueo del Usuario: " + dr["Usuario"].ToString();
                        }
                    }

                  
                }
                else
                {
                    Panel1.Visible = true;
                    lblMensajeBatch.Visible = false;
                    this.Traer_AltasLotes("dbo.SP_I_TraerLotesAIngresarCalipso");
                    this.Traer_BajasSlitter("dbo.SP_I_TraerBajasParaCalipsoSlitter");
                    this.Traer_AltasSlitter("dbo.SP_I_TraerAltasParaCalipsoSlitter");
                    this.Traer_SobranteSlitter("dbo.SP_I_TraerSobranteParaCalipsoSlitter");
                    this.Traer_BajasUO("dbo.SP_I_TraerBajasParaCalipsoUO");
                    this.Traer_AltasUO("dbo.SP_I_TraerAltasParaCalipsoUO");
                    this.Traer_SobranteUO("dbo.SP_I_TraerSobranteUO");
                    this.Traer_BajasCP("dbo.SP_I_TraerBajaCP");
                    this.Traer_AltasCP("dbo.SP_I_TraerAltaCP");
                    //Otros Controles
                    this.Traer_BatchsFabricados("dbo.SP_I_TraerBatchsFabricados");
                    this.Traer_FlagBatchNoCerrado("dbo.SP_I_TraerErroresFlagBatch");
                    this.Traer_OperacionesSL("dbo.SP_I_TraerOperacionesSL");
                    this.Traer_OperacionesUO("dbo.SP_I_TraerOperacionesUO");
                    //this.Traer_AltasDuplicadas("SP_INV_TraerErroresTrInventario");
                    this.Traer_Incidentes("SP_Traer_Incidentes_Monitor");
                    this.Traer_Matching("SP_SIS_TraerMatchingTransactor");
                    this.Traer_TransactorCalipso("SP_I_TraerMensajesTransactor");
                    this.TraerErroresPedidos("SP_VT_TraerErroresPedidos");                  
                    this.Traer_JobBK("SP_TraerJobBackup");
                    this.Traer_Job("SP_TraerJobIntranet");
                    this.TraerEstadosSRP("SP_I_TraerEstadosSRP");
                    this.TraerSobrantesSRP("SP_I_TraerSobrantesSRP");
                    

                    //Notas y Anchos que vuelven a Calipso
                    this.Traer_NotasSL("dbo.SP_TraerNotasSRP_UDloteSL");
                    this.Traer_NotasUO("dbo.SP_TraerNotasSRP_UDloteUO");
                    this.ActualizarAnchoSL("dbo.SP_TraerAnchoEnProcesoSL");
                    this.ActualizarAnchoUO("dbo.SP_TraerAnchoEnProcesoUO");

                    //Emails Calipso
                    this.TraerEmailsCalipso("dbo.SP_SIS_TraerEmailsCalipso");
                    this.TraerEmailsMasivos("dbo.SP_MAIL_TraerEmailsaEnviar");
                    


                }


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

       
     

        private void Traer_AltasLotes(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("RegistracionNET");
            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));
              
               
                DataTable dt = unDS.Tables[0].Copy();

                if (dt.Rows.Count > 0)
                {
                    DateTime dHora = (Convert.ToDateTime(unDS.Tables[0].Rows[0]["FechaReg"])).AddMinutes(10);
                    if(dHora > DateTime.Now) 
                    {
                        btnAltasLotesW.Visible = true;
                        btnAltasLotesD.Visible = false;
                        btnAltasLotesOK.Visible = false;
                    }
                    else
                    {
                        btnAltasLotesD.Visible = true;
                        btnAltasLotesW.Visible = false;
                        btnAltasLotesOK.Visible = false;
                    }

                }
                else
                {
                    btnAltasLotesOK.Visible = true;
                    btnAltasLotesD.Visible = false;
                    btnAltasLotesW.Visible = false;
                    
                }


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void Traer_BajasSlitter(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("RegistracionNET");
            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));


                DataTable dt = unDS.Tables[0].Copy();

                if (dt.Rows.Count > 0)
                {
                    DateTime dHora = (Convert.ToDateTime(unDS.Tables[0].Rows[0]["FechaReg"])).AddMinutes(10);
                    if (dHora > DateTime.Now)
                    {
                        btnBajasSLW.Visible = true;
                        btnBajasSLD.Visible = false;
                        btnBajasSLOK.Visible = false;
                    }
                    else
                    {
                        btnBajasSLD.Visible = true;
                        btnBajasSLW.Visible = false;
                        btnBajasSLOK.Visible = false;
                    }

                }
                else
                {
                    btnBajasSLOK.Visible = true;
                    btnBajasSLD.Visible = false;
                    btnBajasSLW.Visible = false;

                }


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
        private void Traer_AltasSlitter(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("RegistracionNET");
            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));


                DataTable dt = unDS.Tables[0].Copy();

                if (dt.Rows.Count > 0)
                {
                    DateTime dHora = (Convert.ToDateTime(unDS.Tables[0].Rows[0]["FechaReg"])).AddMinutes(10);
                    if (dHora > DateTime.Now)
                    {
                        btnAltasSLW.Visible = true;
                        btnAltasSLD.Visible = false;
                        btnAltasSLOK.Visible = false;
                    }
                    else
                    {
                        btnAltasSLD.Visible = true;
                        btnAltasSLW.Visible = false;
                        btnAltasSLOK.Visible = false;
                    }

                }
                else
                {
                    btnAltasSLOK.Visible = true;
                    btnAltasSLD.Visible = false;
                    btnAltasSLW.Visible = false;

                }


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
        private void Traer_SobranteSlitter(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("RegistracionNET");
            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));


                DataTable dt = unDS.Tables[0].Copy();

                if (dt.Rows.Count > 0)
                {
                    DateTime dHora = (Convert.ToDateTime(unDS.Tables[0].Rows[0]["FechaReg"])).AddMinutes(10);
                    if (dHora > DateTime.Now)
                    {
                        btnSobranteSLW.Visible = true;
                        btnSobranteSLD.Visible = false;
                        btnSobranteSLOK.Visible = false;
                    }
                    else
                    {
                        btnSobranteSLD.Visible = true;
                        btnSobranteSLW.Visible = false;
                        btnSobranteSLOK.Visible = false;
                    }

                }
                else
                {
                    btnSobranteSLOK.Visible = true;
                    btnSobranteSLD.Visible = false;
                    btnSobranteSLW.Visible = false;

                }


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
        private void Traer_BajasUO(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("RegistracionNET");
            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));


                DataTable dt = unDS.Tables[0].Copy();

                if (dt.Rows.Count > 0)
                {
                    DateTime dHora = (Convert.ToDateTime(unDS.Tables[0].Rows[0]["FechaReg"])).AddMinutes(10);
                    if (dHora > DateTime.Now)
                    {
                        btnBajasUOW.Visible = true;
                        btnBajasUOD.Visible = false;
                        btnBajasUOOK.Visible = false;
                    }
                    else
                    {
                        btnBajasUOD.Visible = true;
                        btnBajasUOW.Visible = false;
                        btnBajasUOOK.Visible = false;
                    }

                }
                else
                {
                    btnBajasUOOK.Visible = true;
                    btnBajasUOD.Visible = false;
                    btnBajasUOW.Visible = false;

                }


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
        private void Traer_AltasUO(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("RegistracionNET");
            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));


                DataTable dt = unDS.Tables[0].Copy();

                if (dt.Rows.Count > 0)
                {
                    DateTime dHora = (Convert.ToDateTime(unDS.Tables[0].Rows[0]["FechaReg"])).AddMinutes(10);
                    if (dHora > DateTime.Now)
                    {
                        btnAltasUOW.Visible = true;
                        btnAltasUOD.Visible = false;
                        btnAltasUOOK.Visible = false;
                    }
                    else
                    {
                        btnAltasUOD.Visible = true;
                        btnAltasUOW.Visible = false;
                        btnAltasUOOK.Visible = false;
                    }

                }
                else
                {
                    btnAltasUOOK.Visible = true;
                    btnAltasUOD.Visible = false;
                    btnAltasUOW.Visible = false;
                }
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
        private void Traer_SobranteUO(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("RegistracionNET");
            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));


                DataTable dt = unDS.Tables[0].Copy();

                if (dt.Rows.Count > 0)
                {
                    DateTime dHora = (Convert.ToDateTime(unDS.Tables[0].Rows[0]["FechaReg"])).AddMinutes(10);
                    if (dHora > DateTime.Now)
                    {
                        btnSobranteUOW.Visible = true;
                        btnSobranteUOD.Visible = false;
                        btnSobranteUOOK.Visible = false;
                    }
                    else
                    {
                        btnSobranteUOD.Visible = true;
                        btnSobranteUOW.Visible = false;
                        btnSobranteUOOK.Visible = false;
                    }

                }
                else
                {
                    btnSobranteUOOK.Visible = true;
                    btnSobranteUOD.Visible = false;
                    btnSobranteUOW.Visible = false;
                }
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
        private void Traer_BajasCP(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("RegistracionNET");
            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));


                DataTable dt = unDS.Tables[0].Copy();

                if (dt.Rows.Count > 0)
                {
                    DateTime dHora = (Convert.ToDateTime(unDS.Tables[0].Rows[0]["FechaReg"])).AddMinutes(10);
                    if (dHora > DateTime.Now)
                    {
                        btnBajasCPW.Visible = true;
                        btnBajasCPD.Visible = false;
                        btnBajasCPOK.Visible = false;
                    }
                    else
                    {
                        btnBajasCPD.Visible = true;
                        btnBajasCPW.Visible = false;
                        btnBajasCPOK.Visible = false;
                    }

                }
                else
                {
                    btnBajasCPOK.Visible = true;
                    btnBajasCPD.Visible = false;
                    btnBajasCPW.Visible = false;

                }


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
        private void Traer_AltasCP(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("RegistracionNET");
            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));


                DataTable dt = unDS.Tables[0].Copy();

                if (dt.Rows.Count > 0)
                {
                    DateTime dHora = (Convert.ToDateTime(unDS.Tables[0].Rows[0]["FechaReg"])).AddMinutes(10);
                    if (dHora > DateTime.Now)
                    {
                        btnAltasCPW.Visible = true;
                        btnAltasCPD.Visible = false;
                        btnAltasCPOK.Visible = false;
                    }
                    else
                    {
                        btnAltasCPD.Visible = true;
                        btnAltasCPW.Visible = false;
                        btnAltasCPOK.Visible = false;
                    }

                }
                else
                {
                    btnAltasCPOK.Visible = true;
                    btnAltasCPD.Visible = false;
                    btnAltasCPW.Visible = false;
                }
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
        private void Traer_BatchsFabricados(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));


                DataTable dt = unDS.Tables[0].Copy();

                if (dt.Rows.Count > 0)
                {
                    btnBatchD.Visible = true;
                    btnBatchOK.Visible = false;

                }
                else
                {
                    btnBatchOK.Visible = true;
                    btnBatchD.Visible = false;

                }


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }


        private void Traer_OperacionesSL(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("RegistracionNET");
            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));


                DataTable dt = unDS.Tables[0].Copy();

                if (dt.Rows.Count > 0)
                {
                    btnOPSLD.Visible = true;
                    btnOPSLOK.Visible = false;
                    //lblMensajeDuplicadaP.Visible = true;
                    foreach (DataRow dr in dt.Rows)
                    {
                        lblMensajeDuplicadaP.Text = "Referencia-Operacion_ID" + ":" + dr["Operacion_id"].ToString();
                       
                    }


                }
                else
                {
                    btnOPSLOK.Visible = true;
                    btnOPSLD.Visible = false;
                    lblMensajeDuplicadaP.Text = "";

                }


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
        private void Traer_OperacionesUO(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("RegistracionNET");
            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));


                DataTable dt = unDS.Tables[0].Copy();

                if (dt.Rows.Count > 0)
                {
                    btnOPUOOK.Visible = true;
                    btnOPUOD.Visible = false;

                }
                else
                {
                    btnOPUOOK.Visible = true;
                    btnOPUOD.Visible = false;

                }


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
      

        private void Traer_NotasSL(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("RegistracionNET");
            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));

                foreach (DataTable table in unDS.Tables)
                {
                    foreach (DataRow dr in table.Rows)
                    {
                        string sLoteID = dr["Lote_id"].ToString();
                        string sNota = dr["Nota"].ToString();
                        int iId = Convert.ToInt32(dr["id"]);
                        this.Actualizar_NotasUD("dbo.SP_ActualizaNotasSRPCalipso", sLoteID, sNota);
                        this.Actualizar_NotasCalidad("dbo.SP_EditarNotasSRPSL", iId);
                    }
                }
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void Traer_NotasUO(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("RegistracionNET");
            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));

                foreach (DataTable table in unDS.Tables)
                {
                    foreach (DataRow dr in table.Rows)
                    {
                        string sLoteID = dr["Lote_id"].ToString();
                        string sNota = dr["Nota"].ToString();
                        int iId = Convert.ToInt32(dr["id"]);
                        this.Actualizar_NotasUD("dbo.SP_ActualizaNotasSRPCalipso", sLoteID, sNota);
                        this.Actualizar_NotasCalidad("dbo.SP_EditarNotasSRPUO", iId);
                    }
                }
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
        private void Traer_BatchNoCerrado(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));

                foreach (DataTable table in unDS.Tables)
                {
                    foreach (DataRow dr in table.Rows)
                    {
                        string sBatch = dr["Nrobatch"].ToString();
                        this.CerrarBatch("dbo.SP_REG_CambiarFlagFabricado", sBatch);
                    }
                }
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void Traer_JobBK(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));


                DataTable dt = unDS.Tables[0].Copy();

                if (dt.Rows.Count > 0)
                {
                    btnJBD.Visible = true;
                    btnJBOK.Visible = false;

                }
                else
                {
                    btnJBOK.Visible = true;
                    btnJBD.Visible = false;

                }


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void Traer_Job(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));


                DataTable dt = unDS.Tables[0].Copy();

                if (dt.Rows.Count > 0)

                {
                    lblMensajeErrorJob.Visible = true;
                    foreach (DataRow dr in dt.Rows)
                    {
                        lblMensajeErrorJob.Text = "La ejecución del Job denominado  " + dr["JobName"].ToString()
                            + " falló, por favor Ejecutelo desde el Aministrador de SQL ";

                    }
                    btnJD.Visible = true;
                    btnJOK.Visible = false;

                }
                else
                {
                    btnJOK.Visible = true;
                    btnJD.Visible = false;
                    lblMensajeErrorJob.Visible = false;

                }


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerEstadosSRP(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("RegistracionNet");
            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));


                DataTable dt = unDS.Tables[0].Copy();

                if (dt.Rows.Count > 0)
                {
                    btnEstadoSRPD.Visible = true;
                    btnEstadoSRPOK.Visible = false;

                }
                else
                {
                    btnEstadoSRPOK.Visible = true;
                    btnEstadoSRPD.Visible = false;

                }


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerSobrantesSRP(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("RegistracionNet");
            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));


                DataTable dt = unDS.Tables[0].Copy();

                if (dt.Rows.Count > 0)
                {
                    btnSobranteOK.Visible = false;
                    btnSobranteD.Visible = true;
                    lblMensajeSobrante.Visible = true;
                    foreach (DataRow dr in dt.Rows)
                    {
                        lblMensajeSobrante.Text = "Referencia-Serie-Lote" + ":" + dr["LoteSaliente"].ToString();
                        Session["Sobrante"] = dr["LoteSaliente"].ToString();
                    }

                }
                else
                {
                    btnSobranteOK.Visible = true;
                    btnSobranteD.Visible = false;
                    lblMensajeSobrante.Visible = false;
                    Session["Sobrante"] = "";


                }


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void ActualizarAnchoSL(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));

                foreach (DataTable table in unDS.Tables)
                {
                    foreach (DataRow dr in table.Rows)
                    {
                        string sLote = dr["LOTE_ID"].ToString();
                        decimal dAncho = Convert.ToDecimal(dr["Ancho"]);
                        this.ActualizarAncho("dbo.SP_ActualizaAnchoProcesoCalipso", sLote, dAncho);
                    }
                }
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void ActualizarAnchoUO(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));

                foreach (DataTable table in unDS.Tables)
                {
                    foreach (DataRow dr in table.Rows)
                    {
                        string sLote = dr["LOTE_ID"].ToString();
                        decimal dAncho = Convert.ToDecimal(dr["Ancho"]);
                        this.ActualizarAncho("dbo.SP_ActualizaAnchoProcesoCalipso", sLote, dAncho);
                    }
                }
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void ActualizarControlSobrante(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("RegistracionNet");
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Lote_Desc", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["Sobrante"].ToString();

                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreStored), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

        private void Traer_FlagBatchNoCerrado(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));


                DataTable dt = unDS.Tables[0].Copy();

                if (dt.Rows.Count > 0)
                {
                    btnFlagBatchD.Visible = true;
                    btnFlagBatchOK.Visible = false;
                    lblMensajeErrorBatch.Visible = true;
                    foreach (DataRow dr in dt.Rows)
                    {
                        lblMensajeErrorBatch.Text = "Referencia-NroBatch" + ":" + dr["nrobatch"].ToString();

                    }

                }
                else
                {
                    lblMensajeErrorBatch.Visible = false;
                    
                    btnFlagBatchOK.Visible = true;
                    btnFlagBatchD.Visible = false;

                }


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void CerrarBatch(string nombreStored, string sBatch)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Nro_Batch", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = sBatch;

                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreStored), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

        private void TraerEstadoaEditar(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("RegistracionNET");
            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));

                foreach (DataTable table in unDS.Tables)
                {
                    foreach (DataRow dr in table.Rows)
                    {
                        int iIdentificador = Convert.ToInt32(dr["ID"]);
                        int iTabla = Convert.ToInt32(dr["Tabla"]);
                        if (iTabla == 1)
                        {
                            this.EditarEstados("dbo.SP_I_EditarEstadosSRP1", iIdentificador);
                        }
                        else
                        {
                            this.EditarEstados("dbo.SP_I_EditarEstadosSRP2", iIdentificador);
                        } 

                        
                    }
                }
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void ActualizarAncho(string nombreStored, string sLote, Decimal dAncho)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("RegistracionNet");
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@Lote_ID", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = sLote;

                unosParametros[1] = new SqlParameter("@Ancho", System.Data.SqlDbType.Decimal);
                unosParametros[1].Value = dAncho;

                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreStored), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

        private void EditarEstados(string nombreStored, int iIdentificador)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("RegistracionNet");
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("ID", System.Data.SqlDbType.Int);
                unosParametros[0].Value = iIdentificador;

               
                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreStored), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

        private void Actualizar_NotasUD(string nombreStored, string sLoteId, string sNotas)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("RegistracionNet");
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@Lote_ID", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = sLoteId;

                unosParametros[1] = new SqlParameter("@Notas", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = Clases.Varias.RemoveSpecialCharacters(sNotas);


                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreStored), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

        private void Actualizar_NotasCalidad(string nombreStored, int iId)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("RegistracionNet");
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Id", System.Data.SqlDbType.Int);
                unosParametros[0].Value = iId;


                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreStored), unosParametros);

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        //private void Traer_AltasDuplicadas(string nombreStored)
        //{
        //    Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
        //    DataSet unDS = null;

        //    try
        //    {

        //        unAcceso.AbrirConexion();
        //        unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));


        //        DataTable dt = unDS.Tables[0].Copy();

        //        if (dt.Rows.Count > 0)
        //        {
        //            btnControlOK.Visible = false;
        //            btnControlD.Visible = true;
        //            lblMensajeErrorInventario.Visible = true;
        //            foreach (DataRow dr in dt.Rows)
        //            {
        //                lblMensajeErrorInventario.Text = "Referencia-Inventario" + ":" + dr["SL"].ToString()
        //                    + " Deposito Ori:" + dr["DepOri"].ToString() + " Deposito Des:" + dr["DepDes"].ToString()
        //                    + " Tipo:" + dr["Tipo"].ToString() + " ID:" + dr["ID"].ToString();

        //            }
                   

        //        }
        //        else
        //        {
        //            btnControlOK.Visible = true;
        //            btnControlD.Visible = false;
        //            lblMensajeErrorInventario.Visible = false;


        //        }


        //    }
        //    finally
        //    {
        //        unAcceso.CerrarConexion();
        //    }
        //}

     

        private void Traer_Incidentes(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNET");
            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));


                DataTable dt = unDS.Tables[0].Copy();

                if (dt.Rows.Count > 0)
                {
                    btnIncidentesD.Visible = true;
                    btnIncidentesOK.Visible = false;

                }
                else
                {
                    btnIncidentesOK.Visible = true;
                    btnIncidentesD.Visible = false;

                }


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void Traer_Matching(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNET");
            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));


                DataTable dt = unDS.Tables[0].Copy();

                if (dt.Rows.Count > 0)
                {
                    btnMatchingD.Visible = true;
                    btnMatchingOK.Visible = false;

                }
                else
                {
                    btnMatchingOK.Visible = true;
                    btnMatchingD.Visible = false;

                }


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerErroresPedidos(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNET");
            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));

                DataTable dt = unDS.Tables[0].Copy();
                if (dt.Rows.Count > 0)
                {


                    btnODD.Visible = true;
                    btnODOK.Visible = false;

                    theDiv.Visible = true;
                    lblPedido.Text = unDS.Tables[0].Rows[0]["Numero"].ToString();
                    lblCliente.Text = unDS.Tables[0].Rows[0]["Cliente"].ToString();
                    lblError.Text = unDS.Tables[0].Rows[0]["descerror"].ToString();     
    

                    

                }
                else
                {
                    btnODOK.Visible = true;
                    btnODD.Visible = false;
                   
                     theDiv.Visible = false;

                }


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void Traer_TransactorCalipso(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));

                int iMensajes = (Convert.ToInt32(unDS.Tables[0].Rows[0]["Mensajes"]));
                if (iMensajes > 30)
                {
                    btnTransactorD.Visible = true;
                    btnTransactorOK.Visible = false;
                }
                else
                {
                    btnTransactorD.Visible = false;
                    btnTransactorOK.Visible = true;
                }

               
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        protected void btnRefrescar_Click(object sender, EventArgs e)
        {
            this.Traer_Bloqueos("dbo.SP_SIS_TraerBloqueosMaster");    
         


        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            this.Traer_Bloqueos("dbo.SP_SIS_TraerBloqueosMaster");    


        }

        protected void btnBatchD_Click(object sender, EventArgs e)
        {
            this.Traer_BatchNoCerrado("dbo.SP_I_TraerBatchsFabricados");
            this.Traer_Bloqueos("dbo.SP_SIS_TraerBloqueosMaster"); 
        }

      

        protected void btnFlagBatchD_Click(object sender, EventArgs e)
        {
            this.Traer_BatchNoCerrado("dbo.SP_I_TraerErroresFlagBatch");
            this.Traer_Bloqueos("dbo.SP_SIS_TraerBloqueosMaster"); 




        }

        protected void btnEstadoSRPD_Click(object sender, EventArgs e)
        {
            this.TraerEstadoaEditar("SP_I_TraerEstadosSRP");
            this.Traer_Bloqueos("dbo.SP_SIS_TraerBloqueosMaster"); 


        }

        private void ActualizarEmails(string nombreStored, int iIdentificador)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("ID", System.Data.SqlDbType.Int);
                unosParametros[0].Value = iIdentificador;


                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreStored), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

        private void ActualizarEmailsMasivos(string nombreStored, int iIdentificador)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("ID", System.Data.SqlDbType.Int);
                unosParametros[0].Value = iIdentificador;


                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreStored), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

        private void TraerEmailsCalipso(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));

                foreach (DataTable table in unDS.Tables)
                {
                    foreach (DataRow dr in table.Rows)
                    {
                        string sBody = dr["BODY"].ToString();
                        string sSubject = dr["SUBJECT"].ToString();
                        string sDestinatarios = dr["DESTINATARIOS"].ToString().Replace(";",",");
                        int iId = Convert.ToInt32(dr["id"]);

                        

                        this.EnviarEmail(sBody, sSubject, sDestinatarios);
                        this.ActualizarEmails("dbo.SP_SIS_MailEnviado", iId);
                    }
                }
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerEmailsMasivos(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));

                foreach (DataTable table in unDS.Tables)
                {
                    foreach (DataRow dr in table.Rows)
                    {
                        string sBody = dr["CUERPO"].ToString();
                        string sSubject = dr["CABECECERA"].ToString();
                        string sDestinatarios = dr["DESTINATARIOS"].ToString().Replace(";", ",");
                        int iId = Convert.ToInt32(dr["id"]);



                        this.EnviarEmailMasivo(sBody, sSubject, sDestinatarios);
                        this.ActualizarEmailsMasivos("dbo.SP_MAIL_MailEnviado", iId);
                    }
                }
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private bool EnviarEmail(string sBody, string sSubject, string sDestinatarios)            
        {

            MailMessage msg = new MailMessage();

            msg.To.Add(sDestinatarios);
            //msg.To.Add("jnavarro@sintecrom.com.ar, megonzalez@sintecrom.com.ar, ninsua@sintecrom.com.ar");

            msg.From = new MailAddress("mail.sistemas.sintecrom@gmail.com", "Mensaje Enviado desde La Intranet de Sintecrom", System.Text.Encoding.UTF8);

            msg.Subject = sSubject;

            msg.SubjectEncoding = System.Text.Encoding.UTF8;

            msg.Body = sBody;

            msg.BodyEncoding = System.Text.Encoding.UTF8;

            msg.IsBodyHtml = false; //Si vas a enviar un correo con contenido html entonces cambia el valor a true
            //Aquí es donde se hace lo especial

            

            SmtpClient client = new SmtpClient();

            //client.Credentials = new System.Net.NetworkCredential("mail.sistemas.sintecrom@gmail.com", "Sinte1234");

            client.Port = 587;

            client.Host = "smtp.gmail.com";//Este es el smtp valido para Gmail

            client.EnableSsl = true; //Esto es para que vaya a través de SSL que es obligatorio con GMail

            client.UseDefaultCredentials = false;
            //client.Credentials = new System.Net.NetworkCredential("mail.sistemas.sintecrom@gmail.com", "Sinte.2023*");
            client.Credentials = new System.Net.NetworkCredential("mail.sistemas.sintecrom@gmail.com", "elvyffedyeximpwp");
            client.DeliveryMethod = SmtpDeliveryMethod.Network;

            try
            {
                client.Send(msg);

                return true;
            }

            catch (Exception)
            {
                return false;
            }

        }

        private bool EnviarEmailMasivo(string sBody, string sSubject, string sDestinatarios)
        {

            MailMessage msg = new MailMessage();

            if (String.IsNullOrEmpty(sDestinatarios))
            {
                return false;
            }
            else
            {
                msg.To.Add(sDestinatarios);
                //msg.To.Add("jnavarro@sintecrom.com.ar, megonzalez@sintecrom.com.ar, ninsua@sintecrom.com.ar");

                msg.From = new MailAddress("mail.sistemas.sintecrom@gmail.com", "Mensaje Enviado por Sintecrom", System.Text.Encoding.UTF8);

                msg.Subject = sSubject;

                msg.SubjectEncoding = System.Text.Encoding.UTF8;

                msg.Body = sBody;

                msg.BodyEncoding = System.Text.Encoding.UTF8;

                msg.IsBodyHtml = false; //Si vas a enviar un correo con contenido html entonces cambia el valor a true
                                        //Aquí es donde se hace lo especial

                SmtpClient client = new SmtpClient();

                //client.Credentials = new System.Net.NetworkCredential("mail.sistemas.sintecrom@gmail.com", "Sinte1234");

                client.Port = 587;

                client.Host = "smtp.gmail.com";//Este es el smtp valido para Gmail

                client.EnableSsl = true; //Esto es para que vaya a través de SSL que es obligatorio con GMail

                client.UseDefaultCredentials = false;
                //client.Credentials = new System.Net.NetworkCredential("mail.sistemas.sintecrom@gmail.com", "Sinte.2023*");
                client.Credentials = new System.Net.NetworkCredential("mail.sistemas.sintecrom@gmail.com", "elvyffedyeximpwp");
                client.DeliveryMethod = SmtpDeliveryMethod.Network;


                try
                {
                    client.Send(msg);

                    return true;
                }

                catch (Exception)
                {
                    return false;
                }
            }

  


        }

        protected void btnSobranteD_Click(object sender, EventArgs e)
        {
            this.ActualizarControlSobrante("SP_I_ActualizarControlSobrantes");
            this.Traer_Bloqueos("dbo.SP_SIS_TraerBloqueosMaster");

        }
    }
}