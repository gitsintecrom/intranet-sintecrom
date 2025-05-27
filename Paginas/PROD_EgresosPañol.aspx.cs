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
    public partial class PROD_EgresosPañol : System.Web.UI.Page
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

                    if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES") || group == ("DOMINIOW_PANIOL") || group == ("DOMINIOW_EGRESOPANIOL"))
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

                    CargarCombo();

                }

            }
        }

        private void CargarCombo()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_PROD_TraerComboProductosPaniol"));

                ddComboProducto.DataSource = unDS;
                ddComboProducto.DataValueField = "Codigo";
                ddComboProducto.DataTextField = "Descripcion";
                ddComboProducto.DataBind();
                ddComboProducto.Items.Insert(0, new ListItem("Seleccione...", ""));

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
      

        protected void btnEjecutar_Click(object sender, EventArgs e)
        {


            string result = ddComboProducto.SelectedItem.Text.ToString();
            string resultado = "";
            int ilargo = result.Length;
            string start = "Stock:";
            if (result.Contains(start))
            {
                int inicio = result.IndexOf(start, 0) + 6;
                resultado = (result.Substring(inicio, ilargo - inicio));

            }

            if (Convert.ToInt32(txtCantidad.Text) > Convert.ToInt32(resultado))
            {
                Response.Write("<script>window.confirm('La Cantidad que Quiere Egresar no puede ser mayor al Stock Actual');</script>");
                txtCantidad.Focus();
            }

            else
            {
                this.InsertarDatos("dbo.SP_PROD_InsertarNovedadesInsumosManuales");
                Response.Write("<script>window.confirm('La Transacción ha Sido Ingresada Exitosamente');</script>");
                LimpiarCampos();
                CargarCombo();
            }


        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            LimpiarCampos();
           
        }

       
    
        private void InsertarDatos(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[8];


               
                unosParametros[0] = new SqlParameter("@Producto", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = ddComboProducto.SelectedValue;              

                unosParametros[1] = new SqlParameter("@Cantidad", System.Data.SqlDbType.Decimal);
                unosParametros[1].Value = Convert.ToDecimal(txtCantidad.Text);
               
                unosParametros[2] = new SqlParameter("@Tipo", System.Data.SqlDbType.Int);
                unosParametros[2].Value = 1;
               
                unosParametros[3] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = Session["Usr"].ToString();            
                               

                unosParametros[4] = new SqlParameter("@Valor", System.Data.SqlDbType.Decimal);
                unosParametros[4].Value = 0;
                //unosParametros[4].Value = txtValor.Text;

                unosParametros[5] = new SqlParameter("@Moneda", System.Data.SqlDbType.VarChar);
                unosParametros[5].Value = "Baja";

                unosParametros[6] = new SqlParameter("@Cotizacion", System.Data.SqlDbType.Decimal);
                unosParametros[6].Value = 0;

                unosParametros[7] = new SqlParameter("@Destino", System.Data.SqlDbType.VarChar);
                unosParametros[7].Value = txtDestino.Text;




                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

      

        private void LimpiarCampos()
        {
            //ddComboProducto.SelectedValue = "";
            txtCantidad.Text = "0";

        }

      
    

      

       
    }

       
}
