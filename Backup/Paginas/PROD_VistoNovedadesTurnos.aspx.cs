using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Principal;
using System.IO;
using System.Data;
using System.Data.SqlClient;

namespace SintecromNet.Paginas
{
    public partial class PROD_VistoNovedadesTurnos : System.Web.UI.Page
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

                    if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_PRODUCCION")
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
                    string sUsuario = Session["Usr"].ToString().Trim();
                    sUsuario = Clases.Varias.RemoveSpecialCharacters(sUsuario);
                    sUsuario = sUsuario.Replace("DOMINIO", "");
                    Session["Usu"] = sUsuario;
                    this.TraerNovedades(gwIncidentes, "dbo.SP_TraerNovedadesSinVer");
                    ManejoCampos();
                    
                }
            }
          
        }

    
        private void TraerNovedades(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
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
      

    
        protected void Button2_Click1(object sender, EventArgs e)
        {

        }

       


        protected void gwIncidentes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Seleccionar")
            {
                int fila = (Convert.ToInt32(e.CommandArgument));

            }
        }

        protected void imgDetalle_Click(object sender, ImageClickEventArgs e)
        {
            int i = 0;

            foreach (GridViewRow row in this.gwIncidentes.Rows)
            {

                if (((CheckBox)row.FindControl("CheckBox2")).Checked)
                {
                    Session["Numero"] = this.gwIncidentes.Rows[row.RowIndex].Cells[1].Text.ToString();
                    Session["Comentario"] = this.gwIncidentes.Rows[row.RowIndex].Cells[7].Text.ToString();                   
                    i++;
                }
            }



            if (i != 1)
            {
                this.LabelErr.Text = "Debe Seleccionar un solo Incidente";
                HiddenFieldError_ModalPopupExtender.Show();
                return;
            }
            else
            {

                txtComentario.Text = Session["Comentario"].ToString();
            }
        }

        protected void btnCerrar_Click(object sender, EventArgs e)
        {
            this.ActualizarDatos("dbo.SP_PonerVistoNovedad");
            this.TraerNovedades(gwIncidentes, "dbo.SP_TraerNovedadesSinVer");
            ManejoCampos();
        }

        private void ManejoCampos()
        {
            if (gwIncidentes.Rows.Count > 0)
            {
                imgDetalle.Visible = true;
                lblMensaje.Visible = true;
                txtComentario.Visible = true;
                lblComentario.Visible = true;
                btnCerrar.Visible = true;
            }
            else
            {
                imgDetalle.Visible = false;
                lblMensaje.Visible = false;
                txtComentario.Visible = false;
                lblComentario.Visible = false;
                btnCerrar.Visible = false;
            }
        }

        private void ActualizarDatos(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@Numero", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt32(Session["Numero"].ToString());

                unosParametros[1] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = Session["Usu"].ToString().Trim();


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