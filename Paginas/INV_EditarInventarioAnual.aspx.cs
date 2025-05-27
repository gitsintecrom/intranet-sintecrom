using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.DirectoryServices;
using System.DirectoryServices.ActiveDirectory;
using System.Security.Principal;
using System.Web.SessionState;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Xml;
using System.Net;
using System.IO;
using System.Data.SqlClient;
using System.Collections;
using System.Data;
using System.Management;
using System.Text.RegularExpressions;
using System.Drawing;
using System.Web.UI.HtmlControls;


namespace SintecromNet.Paginas
{
    public partial class INV_EditarInventarioAnual : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Cabecera.Visible = true;
                CargarCombo();
                txtBuscar.Focus();
            }
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("..//ContentPage.aspx");
        }

        private void CargarCombo()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_TraerFamilias"));

                ddFamilia.DataSource = unDS;
                ddFamilia.DataValueField = "Codigo";
                ddFamilia.DataTextField = "Descripcion";
                ddFamilia.DataBind();
                ddFamilia.Items.Insert(0, new ListItem("Seleccione...", ""));

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

     

        private void TraerDatos(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;

             SqlParameter[] unosParametros = null;      
            


            try
            {
                unosParametros = new SqlParameter[2];
               
                unosParametros[0] = new SqlParameter("@Serie", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = txtSerie.Text;

                unosParametros[1] = new SqlParameter("@Lote", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = txtLote.Text;

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored),unosParametros);

                DataTable dt = unDS.Tables[0].Copy();
                //int rr =  dt.Rows.Count;
                if (dt.Rows.Count > 0)
                {
                    string sKilos = unDS.Tables[0].Rows[0]["KgsCalipso"].ToString();
                    //Session["Usr"].ToString();
                    Session["KgsCalipso"] = unDS.Tables[0].Rows[0]["KgsCalipso"].ToString();
                    Session["Producto"] = unDS.Tables[0].Rows[0]["CODIGO"].ToString();
                    Session["Lote_ID"] = unDS.Tables[0].Rows[0]["LOTE_ID"].ToString();
                    Session["Serie_ID"] = unDS.Tables[0].Rows[0]["SERIE_ID"].ToString();
                    Session["ProdEstado"] = unDS.Tables[0].Rows[0]["ACTIVESTATUS"].ToString();

                    this.TraerCantDepo("SP_INV_TraerCantDepo");
                    this.TraerDeposito("SP_INV_TraerExisteEnCalipso");



                    if (sKilos != txtCantidad.Text)
                    {
                        //lblKilos.Attributes["style"] = "backcolor:red; font-weight:bold;";
                        lblKilos.BackColor = Color.Red;
                        lblKilos.Text = "Difiere el Stock";
                        Session["Procesar"] = "T";
                        Session["Clasificacion"] = "B";
                    }
                    else
                    {
                        //lblKilos.Attributes["style"] = "backcolor:green; font-weight:bold;";
                        lblKilos.BackColor = Color.Green;
                        lblKilos.Text = "El Stock es Correcto";
                        Session["Procesar"] = "F";
                        Session["Clasificacion"] = "A";
                    }
                }

                else
                {
                    lblKilos.BackColor = Color.Red;
                    lblKilos.Text = "No existe en el Sistema";
                    Session["Clasificacion"] = "C";

                }

               


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerEditarEtiqueta(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;

            SqlParameter[] unosParametros = null;



            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Etiqueta", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt32(txtBuscar.Text);

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);

                DataTable dt = unDS.Tables[0].Copy();
                if (dt.Rows.Count > 0)
                {
                    Ingreso.Visible = true;
                    Cabecera.Visible = false;
                    

                    txtEtiqueta.Text = unDS.Tables[0].Rows[0]["Etiqueta"].ToString();
                    txtEtiqueta.ReadOnly = true;
                    txtGalpon.Text = unDS.Tables[0].Rows[0]["Deposito"].ToString();
                    txtSerie.Text = unDS.Tables[0].Rows[0]["Serie"].ToString();
                    txtLote.Text = unDS.Tables[0].Rows[0]["Lote"].ToString();
                    txtCantidad.Text = unDS.Tables[0].Rows[0]["Kgs"].ToString();
                    ddFamilia.SelectedValue = unDS.Tables[0].Rows[0]["Familia"].ToString();

                    //txtEtiqueta.Focus();

                }
                else
                {
                    Response.Write("<script>window.alert('El Número de Etiqueta NO fue Ingresado');</script>");
                    txtBuscar.Focus();

                }

            }

            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void BorrarEtiqueta(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;

            SqlParameter[] unosParametros = null;



            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Etiqueta", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt32(txtBuscar.Text);

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);

               
            }

            finally
            {
                unAcceso.CerrarConexion();
            }
        }

     

        private void TraerDeposito(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;

            SqlParameter[] unosParametros = null;



            try
            {
                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@Serie", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = txtSerie.Text;

                unosParametros[1] = new SqlParameter("@Lote", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = txtLote.Text;

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);


                Session["Deposito"] = unDS.Tables[0].Rows[0]["DEPOSITO"].ToString();



            }

            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void LimpiarCampos()
        {
            lblResultado.Visible = false;
            lblDepo.Visible = false;
            Respuesta.Visible = false;
            Ingreso.Visible = true;
            txtEtiqueta.Text = "";
            txtGalpon.Text = "";
            txtLote.Text = "";
            txtSerie.Text = "";
            txtCantidad.Text = "";
            ddFamilia.SelectedIndex = 0;

        }

        private void EditarClasificacion(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;

            SqlParameter[] unosParametros = null;



            try
            {
                unosParametros = new SqlParameter[3];

                unosParametros[0] = new SqlParameter("@Lote_ID", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["Lote_IDM"].ToString();

                unosParametros[1] = new SqlParameter("@Clasificacion", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = Session["Clasificacion"].ToString();

                unosParametros[2] = new SqlParameter("@Procesar", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = Session["Procesar"].ToString();
               

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);             



            }

            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerDatosFamilia(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;

            SqlParameter[] unosParametros = null;



            try
            {
                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@Serie", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = txtSerie.Text;

                unosParametros[1] = new SqlParameter("@Lote", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = txtLote.Text;

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);

                 
                DataTable dt = unDS.Tables[0].Copy();
                if (dt.Rows.Count > 0)
                {
                     string sFamilia = unDS.Tables[0].Rows[0]["FAMILIA"].ToString();

                     if (sFamilia != ddFamilia.SelectedValue)
                     {
                         //lblKilos.Attributes["style"] = "backcolor:red; font-weight:bold;";
                         lblResultado.Visible = true;
                         lblResultado.BackColor = Color.Red;
                         lblResultado.Text = "Familia en Sistema " + sFamilia;
                         Session["Clasificacion"] = "D";
                     }
                     else
                     {
                         lblResultado.Visible = false;
                     }
                 }

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerCantDepo(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;

            SqlParameter[] unosParametros = null;



            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Lote_ID", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["Lote_ID"].ToString();
              
                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);


                DataTable dt = unDS.Tables[0].Copy();
                Session["CantDepo"] = 0;
                if (dt.Rows.Count > 0)
                {
                   int iCant = Convert.ToInt16(unDS.Tables[0].Rows[0]["cantdep"]);
                   Session["CantDepo"] = iCant;

                    if (iCant > 1)
                    {
                        //lblKilos.Attributes["style"] = "backcolor:red; font-weight:bold;";
                        lblDepo.Visible = true;
                        lblDepo.BackColor = Color.Blue;
                        lblDepo.ForeColor = Color.White;
                        lblDepo.Text = "SL en mas de 1 Depósito";
                    }
                    else
                    {
                        lblDepo.Visible = false;
                    }
                }

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerDatosIngresados(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;

            SqlParameter[] unosParametros = null;



            try
            {
                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@Serie", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = txtSerie.Text;

                unosParametros[1] = new SqlParameter("@Lote", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = txtLote.Text;

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);

                DataTable dt = unDS.Tables[0].Copy();
                //int rr =  dt.Rows.Count;
                if (dt.Rows.Count > 0)
                {
                    string sKilos = unDS.Tables[0].Rows[0]["KgsCalipso"].ToString();
                    //Session["Usr"].ToString();
                    Session["KgsCalipso"] = unDS.Tables[0].Rows[0]["KgsCalipso"].ToString();
                    Session["Producto"] = unDS.Tables[0].Rows[0]["CODIGO"].ToString();
                    Session["Lote_ID"] = unDS.Tables[0].Rows[0]["LOTE_ID"].ToString();
                    Session["Serie_ID"] = unDS.Tables[0].Rows[0]["SERIE_ID"].ToString();
                    Session["ProdEstado"] = unDS.Tables[0].Rows[0]["ACTIVESTATUS"].ToString();

                    int iCanti = Convert.ToInt32(txtCantidad.Text);
                    int iCant1 = Convert.ToInt32(Session["Cant1"]);
                    int iCantc = Convert.ToInt32(unDS.Tables[0].Rows[0]["KgsCalipso"]);



                    this.TraerCantDepo("SP_INV_TraerCantDepo");
                    this.TraerDeposito("SP_INV_TraerExisteEnCalipso");



                    if (iCanti + iCant1 != iCantc)
                    {
                        //lblKilos.Attributes["style"] = "backcolor:red; font-weight:bold;";
                        lblKilos.BackColor = Color.Red;
                        lblKilos.Text = "Difiere el Stock de Serie en múltiples Etiquetas";
                        Session["Procesar"] = "T";
                        Session["Clasificacion"] = "B";
                    }
                    else
                    {
                        //lblKilos.Attributes["style"] = "backcolor:green; font-weight:bold;";
                        lblKilos.BackColor = Color.Green;
                        lblKilos.Text = "El Stock en múltiples Etiquetas es Correcto";
                        Session["Procesar"] = "F";
                        Session["Clasificacion"] = "A";
                    }
                }


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerLoteIngresado(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;

            SqlParameter[] unosParametros = null;



            try
            {
                unosParametros = new SqlParameter[3];

                unosParametros[0] = new SqlParameter("@Serie", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = txtSerie.Text;

                unosParametros[1] = new SqlParameter("@Lote", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = txtLote.Text;

                unosParametros[2] = new SqlParameter("@Etiqueta", System.Data.SqlDbType.Int);
                unosParametros[2].Value = txtEtiqueta.Text;

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);


                DataTable dt = unDS.Tables[0].Copy();
                
                if (dt.Rows.Count > 0)
                {
                    Session["Modifica"] = "SI";
                    Session["Lote_IDM"] = (unDS.Tables[0].Rows[0]["Lote_ID"]).ToString();
                    Session["Cant1"] = (unDS.Tables[0].Rows[0]["Kilos"]);
                    this.TraerDatosIngresados("SP_INV_TraerStock");
                    this.TraerDatosFamilia("SP_INV_TraerExisteEnCalipsoF");                   
                }
                else
                {
                    Session["Modifica"] = "NO";
                    this.TraerDatos("SP_INV_TraerStock");
                    this.TraerDatosFamilia("SP_INV_TraerExisteEnCalipsoF");
                }

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void EditarDatos(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[15];



                unosParametros[0] = new SqlParameter("@Etiqueta", System.Data.SqlDbType.Int);
                unosParametros[0].Value = txtEtiqueta.Text.Trim();

                unosParametros[1] = new SqlParameter("@Galpon", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = txtGalpon.Text;

                unosParametros[2] = new SqlParameter("@Serie", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = txtSerie.Text.Trim();

                unosParametros[3] = new SqlParameter("@Serie_ID", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = Session["Serie_ID"].ToString();

                unosParametros[4] = new SqlParameter("@Lote", System.Data.SqlDbType.VarChar);
                unosParametros[4].Value = txtLote.Text;

                unosParametros[5] = new SqlParameter("@Lote_ID", System.Data.SqlDbType.VarChar);
                unosParametros[5].Value = Session["Lote_ID"].ToString();

                unosParametros[6] = new SqlParameter("@Familia", System.Data.SqlDbType.VarChar);
                unosParametros[6].Value = ddFamilia.SelectedValue;

                unosParametros[7] = new SqlParameter("@Kilos", System.Data.SqlDbType.Decimal);
                unosParametros[7].Value = txtCantidad.Text;

                unosParametros[8] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[8].Value = Session["Usr"].ToString();

                unosParametros[9] = new SqlParameter("@DepositoCalipso", System.Data.SqlDbType.VarChar);
                unosParametros[9].Value = Session["Deposito"].ToString();

                unosParametros[10] = new SqlParameter("@Procesar", System.Data.SqlDbType.VarChar);
                unosParametros[10].Value = Session["Procesar"].ToString();

                unosParametros[11] = new SqlParameter("@Clasificacion", System.Data.SqlDbType.VarChar);
                unosParametros[11].Value = Session["Clasificacion"].ToString();

                unosParametros[12] = new SqlParameter("@KilosCalipso", System.Data.SqlDbType.Decimal);
                unosParametros[12].Value = Convert.ToDecimal(Session["KgsCalipso"]);

                unosParametros[13] = new SqlParameter("@CantDepo", System.Data.SqlDbType.VarChar);
                unosParametros[13].Value = Session["CantDepo"].ToString();

                unosParametros[14] = new SqlParameter("@Producto", System.Data.SqlDbType.VarChar);
                unosParametros[14].Value = Session["Producto"].ToString();
               
                
                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

        protected void btnCerrar0_Click(object sender, EventArgs e)
        {
            Ingreso.Visible = false;
            Respuesta.Visible = true;
            this.TraerLoteIngresado("SP_INV_TraerEdicionEtiquetasXSL");     

        }

        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Ingreso.Visible = true;
            Respuesta.Visible = false;
        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
           if(Session["Modifica"].ToString() == "SI")
           {
               this.EditarClasificacion("SP_INV_EditarEtiquetas");
           }


           this.EditarDatos("SP_INV_EditarEtiquetasIngresadas");
            this.LimpiarCampos();
            Cabecera.Visible = true;
            Ingreso.Visible = false;
            Respuesta.Visible = false;
            txtBuscar.Text = "0";
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            if (txtBuscar.Text == "")

            {
                txtBuscar.Focus();
            }
            else
            {
                this.TraerEditarEtiqueta("SP_INV_TraerEtiquetasIngresadas");

            }
        }

        protected void btnBorrar_Click(object sender, EventArgs e)
        {
            this.BorrarEtiqueta("SP_INV_BorrarEtiqueta");
            LimpiarCampos();
            Cabecera.Visible = true;
            Ingreso.Visible = false;
            txtBuscar.Text = "0";

        }

        protected void btnBuscarOtra_Click(object sender, EventArgs e)
        {
            Cabecera.Visible = true;
            Ingreso.Visible = false;
            txtBuscar.Text = "0";
        }
    }
}