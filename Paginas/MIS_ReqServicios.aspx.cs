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


namespace SintecromNet.Paginas
{
    public partial class MIS_ReqServicios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //Session["Accede"] = "NO";



                //IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                //foreach (IdentityReference i in irc)
                //{
                //    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                //    if (group == "DOMINIOW_SISTEMAS")
                //    {

                //        Session["Accede"] = "OK";


                //    }

                //}
                //if (Session["Accede"].ToString() == "NO")
                //{
                //    Response.Redirect("Restringida.aspx");
                //}
                //else
                //{                    
                this.TraerOC_Servicios(gwOCServicios, "dbo.SP_I_TraerOrdenesDeComprasServiciosUS");

                //}
              
            }

        
        }

        private void TraerOC_Servicios(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            string usuario = Clases.Varias.RemoveSpecialCharacters(Session["usr"].ToString());
            usuario = usuario.Replace("DOMINIO", "");
           

            try
            {

              
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value =usuario;


               

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);
                

                unGrid.DataSource = unDS;

                unGrid.DataBind();
                DataTable dt = unDS.Tables[0].Copy();


                Session["Tabla"] = dt;

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
      

        protected void Button2_Click1(object sender, EventArgs e)
        {

        }

        protected void btnExcel_Click(object sender, ImageClickEventArgs e)
        {
            string nombre = "EstadoCartera" + DateTime.Now.ToShortDateString();
            DataTable tabla = (DataTable)(Session["Tabla"]);

            Clases.Varias.ExportToSpreadsheet(tabla, nombre);
        }

      

        protected void gwOCServicios_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onMouseOver", "this.style.background='#f2d9d9';this.style.cursor='pointer'");

                e.Row.Attributes.Add("onMouseOut", "this.style.background='#ffffff'");


                e.Row.Attributes["onClick"] = ClientScript.GetPostBackClientHyperlink(this.gwOCServicios, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Haga Click para Seleccionar la línea.";

            }
        }

        protected void gwOCServicios_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gwOCServicios.SelectedRow;
            HiddenFieldError_ModalPopupExtender.Show();
            txtOrdendeCompra.Text = row.Cells[1].Text;
            txtPorcentaje.Text = row.Cells[7].Text;
            txtPorcentaje.Focus();

        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {

                this.ActualizarDatos("dbo.SP_I_ActualizaOCServicios");
                btnModificar.Enabled = false;
                this.TraerOC_Servicios(gwOCServicios, "dbo.SP_I_TraerOrdenesDeComprasServiciosUS");
            

        }

        protected void gwOCServicios_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {

                int index = Convert.ToInt32(e.CommandArgument);


                Session["IDMODI"] = this.gwOCServicios.DataKeys[index].Values[0].ToString();
                btnModificar.Enabled = true;

            }
        }

        private void ActualizarDatos(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");


            try
            {
                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@Id", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["IDMODI"].ToString();

                unosParametros[1] = new SqlParameter("@Porcentaje", System.Data.SqlDbType.Decimal);
                unosParametros[1].Value = txtPorcentaje.Text;//txtPorcentaje.Text.Replace(",", ".");


                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }
     

    

    }

       
}
