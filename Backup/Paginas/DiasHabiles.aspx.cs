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
    public partial class DiasHabiles : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Accede"] = "NO";


            IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
            foreach (IdentityReference i in irc)
            {
                string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                if (group == "DOMINIOW_SISTEMAS")
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
                this.TraerDias(gwDiasHabiles, "dbo.SP_TraeDiasHabiles");
            }
                     
          
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
        private void TraerDias(GridView unGrid, string nombreStored)
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

        protected void gwDiasHabiles_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gwDiasHabiles.EditIndex = e.NewEditIndex;
            Session["Mes"] = this.gwDiasHabiles.Rows[e.NewEditIndex].Cells[0].Text;
            Session["Dia"] = this.gwDiasHabiles.Rows[e.NewEditIndex].Cells[1].Text;

            
        }

        protected void gwDiasHabiles_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Editar")
            {
                int fila = (Convert.ToInt32(e.CommandArgument));
                Label1.Visible = true;
                Label2.Visible = true;
                Label3.Visible = true;
                txtDias.Visible = true;
                btnAceptar.Visible = true;

                Label2.Text = this.gwDiasHabiles.Rows[fila].Cells[0].Text.ToString();
               txtDias.Text = this.gwDiasHabiles.Rows[fila].Cells[1].Text.ToString();
                //this.ActualizarDatos(sMes, sDias, "dbo.SP_ActualizaDias ");

                //unAcceso.EjecutarSentencia_NonQuery_Tran("exec dbo.WC2018_EditaPromocion "
                //        + Session["idPromo"] + ",'" + txtPromocion.Text.Trim() + "'," +
                //        txtDescuentoBco.Text + "," + txtDescuentoCom.Text + "," +
                //        txtTope.Text + "," + cboCostoFinanciero.SelectedValue + ",'" +
                //        fechainicio + "','" + fechafinal + "','" + Session["modificarCuotas"].ToString() + "'");

                //this.TraerDias(gwDiasHabiles, "dbo.SP_TraeDiasHabiles");             
              
            }
        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {

            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            try
            {
                unAcceso.AbrirConexion();

                unAcceso.EjecutarSentencia_NonQuery("exec dbo.SP_ActualizaDias " + Label2.Text + "," + txtDias.Text );


            }
           
            finally
            {
                unAcceso.CerrarConexion();
            }
            Label1.Visible = false;
            Label2.Visible = false;
            Label3.Visible = false;
            txtDias.Visible = false;
            btnAceptar.Visible = false;
            this.TraerDias(gwDiasHabiles, "dbo.SP_TraeDiasHabiles");

        }

      
        
    }
     
}