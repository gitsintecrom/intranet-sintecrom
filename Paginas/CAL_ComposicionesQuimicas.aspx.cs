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
    public partial class CAL_ComposicionesQuimicas : System.Web.UI.Page
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

                    if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_CALIDAD")
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
                    this.TraerComposiciones(gwComposicionesQuimicas, "dbo.SP_I_TraerComposicionesQuimicas");

                }
              
            }

        
        }

        private void TraerComposiciones(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
            DataSet unDS = null;
            

            try
            {

               

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));
                

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
            Panel2.Visible = false;

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


                e.Row.Attributes["onClick"] = ClientScript.GetPostBackClientHyperlink(this.gwComposicionesQuimicas, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Haga Click para Seleccionar la línea.";

            }
        }

        protected void gwOCServicios_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gwComposicionesQuimicas.SelectedRow;
            txtFamilia.Text = row.Cells[1].Text;
            txtAleacion.Text = row.Cells[2].Text;
            txtCarbono.Focus();
            txtCarbono.Text = row.Cells[3].Text;
            txtManganeso.Text = row.Cells[4].Text;
            txtFosforo.Text = row.Cells[5].Text;
            txtAzufre.Text = row.Cells[6].Text;
            txtSilicio.Text = row.Cells[7].Text;
            txtTalio.Text = row.Cells[8].Text;
            txtCobre.Text = row.Cells[9].Text;
            txtAluminio.Text = row.Cells[10].Text;
            txtHierro.Text = row.Cells[11].Text;
            txtMagnesio.Text = row.Cells[12].Text;
            txtCromo.Text = row.Cells[13].Text;
            txtCinc.Text = row.Cells[14].Text;
            txtVanadio.Text = row.Cells[15].Text;
            txtSiFe.Text = row.Cells[16].Text;
            txtOtros.Text = row.Cells[17].Text;
            txtNotas.Text = row.Cells[18].Text;

        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            this.ActualizarDatos("dbo.SP_I_ActualizaComposicionesQuimicas");
            btnModificar.Enabled = false;
            Panel2.Visible = false;
            this.TraerComposiciones(gwComposicionesQuimicas, "dbo.SP_I_TraerComposicionesQuimicas");
           
        }

        protected void gwOCServicios_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {

                int index = Convert.ToInt32(e.CommandArgument);


                Session["IDMODI"] = this.gwComposicionesQuimicas.DataKeys[index].Values[0].ToString();
                Panel2.Visible = true;
                btnModificar.Enabled = true;


            }
        }

        private void ActualizarDatos(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");


            try
            {
                unosParametros = new SqlParameter[17];

                unosParametros[0] = new SqlParameter("@Id", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["IDMODI"].ToString();

                unosParametros[1] = new SqlParameter("@Carbono", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = txtCarbono.Text;

                unosParametros[2] = new SqlParameter("@Manganeso", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = txtManganeso.Text;

                unosParametros[3] = new SqlParameter("@Fosforo", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = txtFosforo.Text;

                unosParametros[4] = new SqlParameter("@Azufre", System.Data.SqlDbType.VarChar);
                unosParametros[4].Value = txtAzufre.Text;

                unosParametros[5] = new SqlParameter("@Silicio", System.Data.SqlDbType.VarChar);
                unosParametros[5].Value = txtSilicio.Text;

                unosParametros[6] = new SqlParameter("@Talio", System.Data.SqlDbType.VarChar);
                unosParametros[6].Value = txtTalio.Text;

                unosParametros[7] = new SqlParameter("@Cobre", System.Data.SqlDbType.VarChar);
                unosParametros[7].Value = txtCobre.Text;

                unosParametros[8] = new SqlParameter("@Aluminio", System.Data.SqlDbType.VarChar);
                unosParametros[8].Value = txtAluminio.Text;

                unosParametros[9] = new SqlParameter("@Hierro", System.Data.SqlDbType.VarChar);
                unosParametros[9].Value = txtHierro.Text;

                unosParametros[10] = new SqlParameter("@Magnesio", System.Data.SqlDbType.VarChar);
                unosParametros[10].Value = txtMagnesio.Text;

                unosParametros[11] = new SqlParameter("@Cromo", System.Data.SqlDbType.VarChar);
                unosParametros[11].Value = txtCromo.Text;

                unosParametros[12] = new SqlParameter("@Cinc", System.Data.SqlDbType.VarChar);
                unosParametros[12].Value = txtCinc.Text;

                unosParametros[13] = new SqlParameter("@Vanadio", System.Data.SqlDbType.VarChar);
                unosParametros[13].Value = txtVanadio.Text;

                unosParametros[14] = new SqlParameter("@SiFe", System.Data.SqlDbType.VarChar);
                unosParametros[14].Value = txtSiFe.Text;

                unosParametros[15] = new SqlParameter("@Otros", System.Data.SqlDbType.VarChar);
                unosParametros[15].Value = txtOtros.Text;

                unosParametros[16] = new SqlParameter("@Notas", System.Data.SqlDbType.VarChar);
                unosParametros[16].Value = txtNotas.Text;

         

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
