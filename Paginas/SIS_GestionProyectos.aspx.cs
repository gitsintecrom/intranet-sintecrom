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
    public partial class SIS_GestionProyectos : System.Web.UI.Page
    {
        public string sGerencia = "Sistemas";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["Accede"] = "NO";

                IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                foreach (IdentityReference i in irc)
                {
                    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                    if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES") )
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

                    this.TraerGrilla(gwGrilla, "SIS_TraerProyectos");

                }

            }
        }
      

        protected void btnEjecutar_Click(object sender, EventArgs e)
        {
          
            if(Session["Accion"].ToString() == "A")
            {
                this.InsertarDatos("dbo.SIS_InsertarProyectos");
                LimpiarCampos();
                Response.Write("<script>window.confirm('El Proyecto ha Sido Ingresado Exitosamente');</script>");
                LimpiarCampos();
                Panel1.Visible = false;
                Panel2.Visible = true;
                this.TraerGrilla(gwGrilla, "SIS_TraerProyectos");
                
            }

            else
            {
                if (Session["Accion"].ToString() == "M")
                {
                    this.EditarDatos("dbo.SIS_EditarProyectos");
                    LimpiarCampos();
                    Panel1.Visible = false;
                    Panel2.Visible = true;
                    this.TraerGrilla(gwGrilla, "SIS_TraerProyectos");
                }
               
            }
           
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            LimpiarCampos();
            Panel1.Visible = false;
            Panel2.Visible = true;
        }

        private void TraerGrilla(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("Sistemas");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;

            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Gerencia", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = sGerencia;

                unAcceso.AbrirConexion();

                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);


                unGrid.DataSource = unDS;

                unGrid.DataBind();


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

    
        private void InsertarDatos(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("Sistemas");


            try
            {
                unosParametros = new SqlParameter[11];


               
                unosParametros[0] = new SqlParameter("@Nombre", System.Data.SqlDbType.NVarChar);
                unosParametros[0].Value = txtDescripcion.Text.Trim();

                unosParametros[1] = new SqlParameter("@Usuario", System.Data.SqlDbType.NVarChar);
                unosParametros[1].Value = txtSolicitante.Text.Trim();

                unosParametros[2] = new SqlParameter("@Sector", System.Data.SqlDbType.NVarChar);
                unosParametros[2].Value = txtSector.Text.Trim();

                unosParametros[3] = new SqlParameter("@Detalle", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = txtDetalle.Text.Trim();

                unosParametros[4] = new SqlParameter("@Responsables", System.Data.SqlDbType.NVarChar);
                unosParametros[4].Value = txtResponsables.Text.Trim();

                unosParametros[5] = new SqlParameter("@Costo", System.Data.SqlDbType.Decimal);
                unosParametros[5].Value = Convert.ToDecimal(txtCosto.Text);

                unosParametros[6] = new SqlParameter("@Tiempo", System.Data.SqlDbType.Int);
                unosParametros[6].Value = txtTiempo.Text.Trim();

                unosParametros[7] = new SqlParameter("@Gerencia", System.Data.SqlDbType.VarChar);
                unosParametros[7].Value = sGerencia;

                unosParametros[8] = new SqlParameter("@Estado", System.Data.SqlDbType.Int);
                unosParametros[8].Value = DropDownList1.SelectedValue;

                unosParametros[9] = new SqlParameter("@Inicio", System.Data.SqlDbType.DateTime);
                unosParametros[9].Value = TextBoxIni.Text;

                unosParametros[10] = new SqlParameter("@Fin", System.Data.SqlDbType.DateTime);
                unosParametros[10].Value = TextBoxFin.Text;




                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

        private void EditarDatos(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("Sistemas");


            try
            {
                unosParametros = new SqlParameter[11];


                unosParametros[0] = new SqlParameter("@Nombre", System.Data.SqlDbType.NVarChar);
                unosParametros[0].Value = txtDescripcion.Text.Trim();

                unosParametros[1] = new SqlParameter("@Usuario", System.Data.SqlDbType.NVarChar);
                unosParametros[1].Value = txtSolicitante.Text.Trim();

                unosParametros[2] = new SqlParameter("@Sector", System.Data.SqlDbType.NVarChar);
                unosParametros[2].Value = txtSector.Text.Trim();

                unosParametros[3] = new SqlParameter("@Detalle", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = txtDetalle.Text.Trim();

                unosParametros[4] = new SqlParameter("@Responsables", System.Data.SqlDbType.NVarChar);
                unosParametros[4].Value = txtResponsables.Text.Trim();

                unosParametros[5] = new SqlParameter("@Costo", System.Data.SqlDbType.Decimal);
                unosParametros[5].Value = Convert.ToDecimal(txtCosto.Text);

                unosParametros[6] = new SqlParameter("@Tiempo", System.Data.SqlDbType.Int);
                unosParametros[6].Value = txtTiempo.Text.Trim();              

                unosParametros[7] = new SqlParameter("@Estado", System.Data.SqlDbType.Int);
                unosParametros[7].Value = DropDownList1.SelectedValue;

                unosParametros[8] = new SqlParameter("@ID", System.Data.SqlDbType.Int);
                unosParametros[8].Value = Convert.ToInt32(Session["ID"]);

                unosParametros[9] = new SqlParameter("@Inicio", System.Data.SqlDbType.DateTime);
                unosParametros[9].Value = TextBoxIni.Text;

                unosParametros[10] = new SqlParameter("@Fin", System.Data.SqlDbType.DateTime);
                unosParametros[10].Value = TextBoxFin.Text;





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
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("Sistemas");


            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@ID", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt32(Session["ID"]);



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
            txtSector.Text = "";
            txtDescripcion.Text = "";
            txtSolicitante.Text = "";
            txtResponsables.Text = "";
            txtCosto.Text = "0";
            DropDownList1.SelectedValue = "0";
            txtTiempo.Text = "0";
            txtDetalle.Text = "";

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
                Session["ID"] = this.gwGrilla.DataKeys[index].Values[10].ToString();
                Session["Accion"] = "M";
                Label1.Text = "Editar Proyecto";
                txtDescripcion.Text = this.gwGrilla.DataKeys[index].Values[0].ToString();
                txtSolicitante.Text = this.gwGrilla.DataKeys[index].Values[1].ToString();
                txtSector.Text = this.gwGrilla.DataKeys[index].Values[2].ToString();
                txtResponsables.Text = this.gwGrilla.DataKeys[index].Values[6].ToString();
                TextBoxIni.Text = this.gwGrilla.DataKeys[index].Values[4].ToString();
                TextBoxFin.Text = this.gwGrilla.DataKeys[index].Values[5].ToString();
                txtDetalle.Text = this.gwGrilla.DataKeys[index].Values[3].ToString();
                txtCosto.Text = this.gwGrilla.DataKeys[index].Values[7].ToString().Replace(",", ".");
                DropDownList1.SelectedValue = this.gwGrilla.DataKeys[index].Values[9].ToString();
                txtTiempo.Text = this.gwGrilla.DataKeys[index].Values[8].ToString();
                

                
                Panel2.Visible = false;

            }

            if (e.CommandName == "Eliminar")
            {


                int index = Convert.ToInt32(e.CommandArgument);
                Panel1.Visible = true;
                Session["ID"] = this.gwGrilla.DataKeys[index].Values[10].ToString();
                Session["Accion"] = "B";
                this.EliminarDatos("dbo.SIS_EliminarProyectos");
                this.TraerGrilla(gwGrilla, "SIS_TraerProyectos");

               


            }
        }

      

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Session["Accion"] = "A";
            Panel1.Visible = true;
            Panel2.Visible = false;
            Label1.Text = "Ingrese un nuevo Proyecto";
        }


       
    }

       
}
