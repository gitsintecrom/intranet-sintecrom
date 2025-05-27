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
    public partial class ADM_ComunicacionAmbiental : System.Web.UI.Page
    {
       

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["Accede"] = "NO";
                Session["Accion"] = "";
                Session["Nombre"] = "";



                IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                foreach (IdentityReference i in irc)
                {
                    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                    if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES") || group == ("DOMINIOW_ADMINISTRACION") || group == ("DOMINIOW_RECEPCION"))
                        
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
                    this.LlenarGrilla(gwGrilla, "dbo.SP_TraerComunicaciones");
                    string sUsuario = Session["Usr"].ToString();
                    sUsuario = Clases.Varias.RemoveSpecialCharacters(sUsuario);
                    sUsuario = sUsuario.Replace("DOMINIO", "");
                    this.TraerNombreUsuario(sUsuario, "dbo.SP_TraerNombreUsuario");


                }
              
            }

        
        }

        private void TraerNombreUsuario(string sUsuario, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;




            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = sUsuario.Trim();
                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);

                Session["Nombre"] = unDS.Tables[0].Rows[0]["Nombre"].ToString();

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void LlenarGrilla(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            //string sUsuario = Session["Usr"].ToString();
            //sUsuario = Clases.Varias.RemoveSpecialCharacters(sUsuario);
            //sUsuario = sUsuario.Replace("DOMINIO", "");

            

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
            this.EliminarDatos("dbo.SP_EliminarComunicaciones");

            this.LlenarGrilla(gwGrilla, "dbo.SP_TraerComunicaciones");
            Panel2.Visible = false;
            gwGrilla.Visible = true;
            imgAlta.Visible = true;
            lblMensaje.Visible = true;
            txtEnte.Text = "";
            txtDetalle.Text = "";


        }

        


        protected void btnModificar_Click(object sender, EventArgs e)
        {
            if (Session["Accion"].ToString() == "A")
            {
                this.InsertarDatos("dbo.SP_InsertarComunicaciones");

            }
            else
            {
                this.ActualizarDatos("dbo.SP_EditarComunicaciones");
            }
            txtEnte.Text = "";
            CargarCombo();
            txtDetalle.Text = "";
            Panel2.Visible = false;
            gwGrilla.Visible = true;
            this.LlenarGrilla(gwGrilla, "dbo.SP_TraerComunicaciones");
            imgAlta.Visible = true;
            lblMensaje.Visible = true;
        }

      

        private void InsertarDatos(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            string sUsuario = Session["Usr"].ToString();
            sUsuario = Clases.Varias.RemoveSpecialCharacters(sUsuario);
            sUsuario = sUsuario.Replace("DOMINIO", "");


            try
            {
                unosParametros = new SqlParameter[4];

                unosParametros[0] = new SqlParameter("@Ente", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = txtEnte.Text;
               
                unosParametros[1] = new SqlParameter("@Responsable", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = ddResponsable.SelectedItem.Text;

                unosParametros[2] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = ddResponsable.SelectedValue;

                unosParametros[3] = new SqlParameter("@Detalle", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value =  Clases.Varias.RemoveSpecialCharacters(txtDetalle.Text);
                


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
            //txtDefecto.Text = "";
            //txtDescripcion.Text = "";
        }

        private void ActualizarDatos(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[5];

                unosParametros[0] = new SqlParameter("@Id", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["IDMODI"].ToString();

                unosParametros[1] = new SqlParameter("@Ente", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = txtEnte.Text;

                unosParametros[2] = new SqlParameter("@Responsable", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = ddResponsable.SelectedItem.Text;

                unosParametros[3] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = ddResponsable.SelectedValue;

                unosParametros[4] = new SqlParameter("@Detalle", System.Data.SqlDbType.VarChar);
                unosParametros[4].Value = Clases.Varias.RemoveSpecialCharacters(txtDetalle.Text);





                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

        private void EliminarDatos(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Id", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["IDMODI"].ToString();

               




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
                Session["Usuario"] = this.gwGrilla.DataKeys[index].Values[1].ToString();
                //btnModificar.Enabled = true;

            }
        }

        protected void gwGrilla_SelectedIndexChanged(object sender, EventArgs e)
        {
          


            GridViewRow row = gwGrilla.SelectedRow;
            Panel2.Visible = true; ;
            Session["Accion"] = "M";
            CargarCombo();
            txtEnte.Text = row.Cells[2].Text.Trim();
            ddResponsable.SelectedValue = Session["Usuario"].ToString().Trim();
            //ddResponsable.SelectedItem = row.Cells[3].Text.Trim();
            txtDetalle.Text = row.Cells[4].Text.Trim();
            gwGrilla.Visible = false;
            imgAlta.Visible = false;
            lblMensaje.Visible = false;
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
            Panel2.Visible = true;
            LimpioCampos();
            CargarCombo();
            Session["Accion"] = "A";
            gwGrilla.Visible = false;
        }

       
        private void CargarCombo()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_Traer_EmpleadosComunicaciones"));

                ddResponsable.DataSource = unDS;
                ddResponsable.DataValueField = "Usuario";
                ddResponsable.DataTextField = "Nombre";
                ddResponsable.DataBind();
                ddResponsable.Items.Insert(0, new ListItem("Seleccione...", "0"));

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            Panel2.Visible = false;
            gwGrilla.Visible = true;
            imgAlta.Visible = true;
            lblMensaje.Visible = true;
        }

    }

       
}
