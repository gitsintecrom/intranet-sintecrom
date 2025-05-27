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
    public partial class CAL_ComunicacionAmbiental : System.Web.UI.Page
    {
       

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                



                IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                foreach (IdentityReference i in irc)
                {
                    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                    if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES") || group == ("DOMINIOW_CALIDAD"))
                        
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
            string sUsuario = Session["Usr"].ToString();
            sUsuario = Clases.Varias.RemoveSpecialCharacters(sUsuario);
            sUsuario = sUsuario.Replace("DOMINIO", "");

            

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
            txtEnte.Text = row.Cells[2].Text.Trim();
            txtResponsable.Text = row.Cells[3].Text.Trim();
            txtDetalle.Text = row.Cells[4].Text.Trim();
            txtAccion.Text = Session["Usuario"].ToString().Trim();
            gwGrilla.Visible = false;
            imgExporta.Visible = false;
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
            string nombre = "Comunicacion_Ambiental" + DateTime.Now.ToShortDateString();
            DataTable tabla = (DataTable)(Session["Tabla"]);

            Clases.Varias.ExportToSpreadsheet(tabla, nombre);
        }

       
        

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            Panel2.Visible = false;
            gwGrilla.Visible = true;
            imgExporta.Visible = true;
        }

    }

       
}
