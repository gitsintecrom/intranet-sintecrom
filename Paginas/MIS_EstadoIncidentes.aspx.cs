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
    public partial class MIS_EstadoIncidentes : System.Web.UI.Page
    {
        public string FechaInicial = "";
        public string FechaFinal = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string sUsuario = Session["Usr"].ToString().Trim();
            sUsuario = Clases.Varias.RemoveSpecialCharacters(sUsuario);
            sUsuario = sUsuario.Replace("DOMINIO", "");
            Session["Usu"] = sUsuario;
          
        }

        private void ActualizarDatos(string sMes, string sDias, string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

                
             try
            {
                 unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@Mes", System.Data.SqlDbType.Decimal);
                unosParametros[0].Value = sMes;

                unosParametros[1] = new SqlParameter("@Dias", System.Data.SqlDbType.Decimal);
                unosParametros[1].Value = sDias;
                unAcceso.AbrirConexion();
                unAcceso.EjecutarSentencia_NonQuery(nombreSP + unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }

        }
        private void TraerIncidentes(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            //string FechaInicial = "";
            //string FechaFinal = "";

            try
            {

                FechaInicial = this.TextBoxIni.Text;
                FechaFinal = this.TextBoxFin.Text;

                try
                {
                    if (FechaInicial.Trim() != "")
                    {
                        Convert.ToDateTime(FechaInicial);
                        FechaInicial = FechaInicial.Substring(0, 4) + FechaInicial.Substring(5, 2) + FechaInicial.Substring(8, 2);
                    }
                }
                catch (Exception)
                {
                    lblMsg.Visible = true;
                    lblMsg.CssClass = "alert alert-danger";
                    lblMsg.Text = "La Fecha Final Seleccionada No es Valida";
                    return;
                }

                try
                {
                    if (FechaFinal.Trim() != "")
                    {
                        Convert.ToDateTime(FechaFinal);
                        FechaFinal = FechaFinal.Substring(0, 4) + FechaFinal.Substring(5, 2) + FechaFinal.Substring(8, 2);
                    }
                }
                catch (Exception)
                {
                    lblMsg.Visible = true;
                    lblMsg.CssClass = "alert alert-danger";
                    lblMsg.Text = "La Fecha Final Seleccionada No es Valida";
                    return;
                }
                unosParametros = new SqlParameter[4];

                unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = FechaInicial;

                unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = FechaFinal;

                unosParametros[2] = new SqlParameter("@Tipo", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = DropDownList4.SelectedValue;

                unosParametros[3] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = Session["Usu"];
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
      

        protected void ButtonVer_Click(object sender, EventArgs e)
        {
            this.TraerIncidentes(gwIncidentes, "dbo.SP_Traer_MisIncidentes");
            if (gwIncidentes.Rows.Count > 0)
            {
                imgDetalle.Visible = true;
                lblMensaje.Visible = true;
            }
        }

        
       
        private void TraerComentarios(GridView unGrid1, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;

            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Incidente", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt32(Session["NumeroIncidente"]);



                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);


                unGrid1.DataSource = unDS;

                unGrid1.DataBind();




            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

    
        protected void imgDetalle_Click(object sender, ImageClickEventArgs e)
        {
            int i = 0;

            foreach (GridViewRow row in this.gwIncidentes.Rows)
            {

                if (((CheckBox)row.FindControl("CheckBox2")).Checked)
                {
                    Session["NumeroIncidente"] = this.gwIncidentes.Rows[row.RowIndex].Cells[1].Text.ToString();                   
                    i++;
                }
            }



            if (i != 1)
            {
                lblMsg.Visible = true;
                lblMsg.CssClass = "alert alert-danger";
                lblMsg.Text = "Debe Seleccionar un solo Incidente";
                return;
            }
            else
            {

                gwComentarios.Visible = true;
                this.TraerComentarios(gwComentarios, "dbo.SP_Traer_Comentarios");
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            this.TraerIncidentes(gwIncidentes, "dbo.SP_Traer_MisIncidentes");
            if (gwIncidentes.Rows.Count > 0)
            {
                imgDetalle.Visible = true;
                lblMensaje.Visible = true;
            }
        }

        protected void imgDetalle_Click1(object sender, ImageClickEventArgs e)
        {
             int i = 0;

            foreach (GridViewRow row in this.gwIncidentes.Rows)
            {

                if (((CheckBox)row.FindControl("CheckBox2")).Checked)
                {
                    Session["NumeroIncidente"] = this.gwIncidentes.Rows[row.RowIndex].Cells[1].Text.ToString();                   
                    i++;
                }
            }



            if (i != 1)
            {
                lblMsg.Visible = true;
                lblMsg.CssClass = "alert alert-danger";
                lblMsg.Text = "Debe Seleccionar un solo Incidente";
                return;
            }
            else
            {

                gwComentarios.Visible = true;
                this.TraerComentarios(gwComentarios, "dbo.SP_Traer_Comentarios");
            }
        
       
        }

        protected void gwIncidentes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Seleccionar")
            {
                int fila = (Convert.ToInt32(e.CommandArgument));

            }
        }

        protected void gwIncidentes_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            this.TraerIncidentes(gwIncidentes, "dbo.SP_Traer_MisIncidentes");
            if (gwIncidentes.Rows.Count > 0)
            {
                imgDetalle.Visible = true;
                lblMensaje.Visible = true;
            }
        }

      
       
      
        
    }
     
}


