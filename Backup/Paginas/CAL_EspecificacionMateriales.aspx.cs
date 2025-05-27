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
    public partial class CAL_EspecificacionMateriales : System.Web.UI.Page
    {
       

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["Accede"] = "NO";
                Session["Accion"] = "";



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
                    this.TraerDefectos(gwGrilla, "dbo.SP_Traer_DefectosMateriales");

                }
              
            }

        
        }

        private void TraerDefectos(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
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

        }

        protected void btnExcel_Click(object sender, ImageClickEventArgs e)
        {
            string nombre = "EstadoCartera" + DateTime.Now.ToShortDateString();
            DataTable tabla = (DataTable)(Session["Tabla"]);

            Clases.Varias.ExportToSpreadsheet(tabla, nombre);
        }

      


        protected void btnModificar_Click(object sender, EventArgs e)
        {
            if (Session["Accion"].ToString() == "A")
            {
                this.InsertarDatos("dbo.SP_InsertarDefectos");
                this.TraerDefectos(gwGrilla, "dbo.SP_Traer_DefectosMateriales");

            }
            else
            {
                this.ActualizarDatos("dbo.SP_EditarDefectos");
                //btnModificar.Enabled = false;
                this.TraerDefectos(gwGrilla, "dbo.SP_Traer_DefectosMateriales");
            }
            
           
        }

      

        private void InsertarDatos(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[3];

                unosParametros[0] = new SqlParameter("@Familia", System.Data.SqlDbType.Char);
                unosParametros[0].Value = ddFamilia.SelectedValue;

                unosParametros[1] = new SqlParameter("@Codigo", System.Data.SqlDbType.Char);
                unosParametros[1].Value = txtDefecto.Text;

                unosParametros[2] = new SqlParameter("@Descripcion", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = txtDescripcion.Text;



                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

        private void LimpioCampos()
        {
            txtDefecto.Text = "";
            txtDescripcion.Text = "";
        }

        private void ActualizarDatos(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[4];

                unosParametros[0] = new SqlParameter("@Id", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["IDMODI"].ToString();

                unosParametros[1] = new SqlParameter("@Familia", System.Data.SqlDbType.Char);
                unosParametros[1].Value = ddFamilia.SelectedValue;

                unosParametros[2] = new SqlParameter("@Codigo", System.Data.SqlDbType.Char);
                unosParametros[2].Value = txtDefecto.Text;

                unosParametros[3] = new SqlParameter("@Descripcion", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = txtDescripcion.Text;


                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

    

        protected void gwGrilla_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {

                int index = Convert.ToInt32(e.CommandArgument);


                Session["IDMODI"] = this.gwGrilla.DataKeys[index].Values[0].ToString();
                //btnModificar.Enabled = true;

            }
        }

        protected void gwGrilla_SelectedIndexChanged(object sender, EventArgs e)
        {
          


            GridViewRow row = gwGrilla.SelectedRow;
            HiddenFieldError_ModalPopupExtender.Show();
            Session["Accion"] = "M";
            CargarCombo();
            ddFamilia.SelectedValue = row.Cells[1].Text.Trim();
            txtDefecto.Text = row.Cells[2].Text;
            txtDescripcion.Text = row.Cells[3].Text;
        }

        protected void gwGrilla_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onMouseOver", "this.style.background='#f2d9d9';this.style.cursor='pointer'");

                e.Row.Attributes.Add("onMouseOut", "this.style.background='#ffffff'");


                e.Row.Attributes["onClick"] = ClientScript.GetPostBackClientHyperlink(this.gwGrilla, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Haga Click para Seleccionar la línea.";

            }
        }

        protected void imgAlta_Click(object sender, ImageClickEventArgs e)
        {
            HiddenFieldError_ModalPopupExtender.Show();
            LimpioCampos();
            CargarCombo();
            Session["Accion"] = "A";
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
                ddFamilia.Items.Insert(0, new ListItem("Seleccione...", "0"));

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

    }

       
}
