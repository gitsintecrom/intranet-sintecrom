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
   
    public partial class PROD_NovedadesPañol : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["Accede"] = "NO";
                Session["Valor"] = 0;
                Session["Moneda"] = "";
                Session["Cotizacion"] = 0;

                IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                foreach (IdentityReference i in irc)
                {
                    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                    if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES") || group == ("DOMINIOW_PANIOL"))
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

                    this.TraerGrilla(gwGrilla, "SP_PROD_NovedadesInsumos");

                }
            }
        }
      

        protected void btnEjecutar_Click(object sender, EventArgs e)
        {

                Session["Respuesta"] = "0";
                this.InsertarDatos("dbo.SP_PROD_InsertarNovedadesInsumos");
                LimpiarCampos();
                Response.Write("<script>window.confirm('El Insumo ha Sido Ingresado Exitosamente al Pañol');</script>");
                Panel1.Visible = false;
                Panel2.Visible = true;
                this.TraerGrilla(gwGrilla, "SP_PROD_NovedadesInsumos");
           
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Session["Respuesta"] = "1";
            this.InsertarDatos("dbo.SP_PROD_InsertarNovedadesInsumos");
            LimpiarCampos();
            Response.Write("<script>window.confirm('El Insumo NO ha Sido Ingresado al Pañol');</script>");
            Panel1.Visible = false;
            Panel2.Visible = true;
            this.TraerGrilla(gwGrilla, "SP_PROD_NovedadesInsumos");
        }

        private void TraerGrilla(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            //SqlParameter[] unosParametros = null;

            try
            {


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));


                unGrid.DataSource = unDS;

                unGrid.DataBind();


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void LimpiarCampos()
        {
            txtRemito.Text = "";
            txtFecha.Text = "";
            txtProducto.Text = "";
            txtDescripcion.Text = "";
            txtCantidad.Text = "";
        }

    
        private void InsertarDatos(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[10];


               
                unosParametros[0] = new SqlParameter("@Remito", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = txtRemito.Text.Trim();

                unosParametros[1] = new SqlParameter("@Producto", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = txtProducto.Text.Trim();

                unosParametros[2] = new SqlParameter("@Cantidad", System.Data.SqlDbType.Decimal);
                unosParametros[2].Value = Convert.ToDecimal(txtCantidad.Text); 
                               
                unosParametros[3] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = Session["Usr"].ToString();

                unosParametros[4] = new SqlParameter("@Respuesta", System.Data.SqlDbType.Int);
                unosParametros[4].Value = Convert.ToInt32(Session["Respuesta"]);

                unosParametros[5] = new SqlParameter("@ItemID", System.Data.SqlDbType.VarChar);
                unosParametros[5].Value = Session["ID"].ToString();

                unosParametros[6] = new SqlParameter("@Tipo", System.Data.SqlDbType.Int);
                unosParametros[6].Value = 0;

                unosParametros[7] = new SqlParameter("@Valor", System.Data.SqlDbType.Decimal);
                unosParametros[7].Value = Session["Valor"];

                unosParametros[8] = new SqlParameter("@Moneda", System.Data.SqlDbType.VarChar);
                unosParametros[8].Value = Session["Moneda"];

                unosParametros[9] = new SqlParameter("@Cotizacion", System.Data.SqlDbType.Decimal);
                unosParametros[9].Value = Session["Cotizacion"];


                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

      

      

     

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Session["Accion"] = "A";
            Panel1.Visible = true;
        }

        protected void gwGrilla_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Editar")           
            {
                
        int index = Convert.ToInt32(e.CommandArgument);
                Panel1.Visible = true;

               
                txtRemito.Text = this.gwGrilla.DataKeys[index].Values[0].ToString();
                txtFecha.Text = this.gwGrilla.DataKeys[index].Values[1].ToString().Substring(0,9);
                txtProducto.Text = this.gwGrilla.DataKeys[index].Values[2].ToString();
                decimal dCantidad = Convert.ToDecimal(this.gwGrilla.DataKeys[index].Values[3].ToString());
                txtCantidad.Text = dCantidad.ToString("N2");
                Session["ID"] = this.gwGrilla.DataKeys[index].Values[4].ToString();
                txtDescripcion.Text = this.gwGrilla.DataKeys[index].Values[5].ToString();
                Session["Valor"] = Convert.ToDecimal(this.gwGrilla.DataKeys[index].Values[6]);
                Session["Moneda"] = this.gwGrilla.DataKeys[index].Values[7].ToString();
                Session["Cotizacion"] = Convert.ToDecimal(this.gwGrilla.DataKeys[index].Values[8]);




                Panel2.Visible = false;

            }

          
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Panel1.Visible = false;
            Panel2.Visible = true;
        }

        


       
    }

       
}
