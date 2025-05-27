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
    public partial class MIS_ComunicacionAmbiental : System.Web.UI.Page
    {
       

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                               
                    this.LlenarGrilla(gwGrilla, "dbo.SP_TraerMisComunicaciones");
              
            }

        
        }

       

        private void LlenarGrilla(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            string usuario = Clases.Varias.RemoveSpecialCharacters(Session["usr"].ToString());
            usuario = usuario.Replace("DOMINIO", "");


            try
            {


                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = usuario;




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
      


        protected void btnModificar_Click(object sender, EventArgs e)
        {
           
            
            this.ActualizarDatos("dbo.SP_EditarMisComunicaciones");
            
            this.LlenarGrilla(gwGrilla, "dbo.SP_TraerMisComunicaciones");
            Panel2.Visible = false;
            gwGrilla.Visible = true;
          
        }

      


       

        private void ActualizarDatos(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@Id", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["IDMODI"].ToString();

                unosParametros[1] = new SqlParameter("@Accion", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = Clases.Varias.RemoveSpecialCharacters(txtAccion.Text);





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
                Session["Accion"] = this.gwGrilla.DataKeys[index].Values[1].ToString();
                //btnModificar.Enabled = true;

            }
        }

        protected void gwGrilla_SelectedIndexChanged(object sender, EventArgs e)
        {
          


            GridViewRow row = gwGrilla.SelectedRow;
            Panel2.Visible = true; ;
            txtEnte.Text = row.Cells[2].Text.Trim();
            txtDetalle.Text = row.Cells[4].Text.Trim();
            txtAccion.Text = Session["Accion"].ToString();
            txtAccion.Focus();
            gwGrilla.Visible = false;
           
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

      

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            Panel2.Visible = false;
            gwGrilla.Visible = true;
            
        }

    }

       
}
