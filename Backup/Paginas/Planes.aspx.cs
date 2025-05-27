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
    public partial class Planes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["Accede"] = "NO";
                Session["PesoFleje"] = 0;
                Session["PesoHoja"] = 0;
                Session["PesoTotal"] = 0;
                Session["Tipo"] = "";



                IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                foreach (IdentityReference i in irc)
                {
                    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                    if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_SUPPLYCHAIN")
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
                    this.TraerPlanes(gwPlanes, "dbo.SP_TraerPlanes");
                }


            }
        }

        private void ActualizarDatos(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

                
             try
            {
                unosParametros = new SqlParameter[4];

                unosParametros[0] = new SqlParameter("@Id", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt16(Session["ID"]);
                 
                unosParametros[1] = new SqlParameter("@PesoFleje", System.Data.SqlDbType.Decimal);
                unosParametros[1].Value = Session["PesoFleje"];

                unosParametros[2] = new SqlParameter("@PesoHoja", System.Data.SqlDbType.Decimal);
                unosParametros[2].Value = Session["PesoHoja"];

                unosParametros[3] = new SqlParameter("@PesoTotal", System.Data.SqlDbType.Decimal);
                unosParametros[3].Value = Session["PesoTotal"];


                
                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }

        }
        private void TraerPlanes(GridView unGrid, string nombreStored)
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

      
        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            Session["PesoFleje"] = txtPesoFleje.Text.Replace('.', ',');
            Session["PesoHoja"] = txtPesoHoja.Text.Replace('.', ',');
            Session["PesoTotal"] = txtPesoTotal.Text.Replace('.', ',');
            
            this.ActualizarDatos("dbo.SP_ActualizaPlanes");
           
            Label6.Visible = false;
            Label7.Visible = false;
            Label8.Visible = false;
            txtPesoTotal.Visible = false;
            txtPesoFleje.Visible = false;
            txtPesoHoja.Visible = false;
            btnAceptar.Visible = false;
            this.TraerPlanes(gwPlanes, "dbo.SP_TraerPlanes");

        }

        protected void gwPlanes_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gwPlanes.EditIndex = e.NewEditIndex;
        }

        protected void gwPlanes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Editar")
            {


                int fila = (Convert.ToInt32(e.CommandArgument));
                string sTipo = this.gwPlanes.Rows[fila].Cells[0].Text.ToString();

                Session["PesoFleje"] = this.gwPlanes.Rows[fila].Cells[2].Text.ToString();

                Session["PesoHoja"] = this.gwPlanes.Rows[fila].Cells[3].Text.ToString();
                
                Session["PesoTotal"] = this.gwPlanes.Rows[fila].Cells[4].Text.ToString();
                
                Session["ID"] = this.gwPlanes.DataKeys[fila].Values[0].ToString();

               

                if (sTipo == "Despacho")
                {
                    Label6.Visible = false;
                    Label7.Visible = false;
                    Label8.Visible = true;
                    txtPesoFleje.Visible = false;
                    txtPesoHoja.Visible = false;
                    txtPesoTotal.Visible = true;
                    btnAceptar.Visible = true;

                    txtPesoTotal.Text = Session["PesoTotal"].ToString().Replace(',','.');
                }
                else
                {
                    Label6.Visible = true;
                    Label7.Visible = true;
                    Label8.Visible = true;
                    txtPesoFleje.Visible = true;
                    txtPesoHoja.Visible = true;
                    txtPesoTotal.Visible = true;
                    btnAceptar.Visible = true;

                    txtPesoTotal.Text = Session["PesoTotal"].ToString().Replace(',', '.');
                    txtPesoFleje.Text = Session["PesoFleje"].ToString().Replace(',', '.');
                    txtPesoHoja.Text = Session["PesoHoja"].ToString().Replace(',', '.');
                }


            }
        }

      
        
    }
     
}