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
using System.Globalization;
using Microsoft.Reporting.WebForms;


namespace SintecromNet.Paginas
{
    public partial class COM_GestionMateriasPrimasPendientes : System.Web.UI.Page
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

                    if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_COMPRAS" || group == "DOMINIOW_GERENTES")
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
                    

                }
              
            }

        
        }

        private void TraerGrilla(GridView unGrid, string nombreStored)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            

            try
            {
                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@NumeroOC", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = txtOrdenCompraB.Text;

                unosParametros[1] = new SqlParameter("@Proveedor", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = txtProveedorB.Text;

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
      

        protected void Button2_Click1(object sender, EventArgs e)
        {

        }


        protected void btnModificar_Click(object sender, EventArgs e)
        {

            this.ActualizarDatos("dbo.SP_COM_SaldarPendientesOC");
            this.TraerGrilla(gwGrilla, "dbo.SP_COM_GestionOCPendientes");





            this.InsertarLog("SP_COM_InsertarLogComex");
        }

         


          private void InsertarLog(string nombreSP)
          {
              SqlParameter[] unosParametros = null;
              Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
              //string yourDateString = txtFechaEntrega.Text;

              try
              {
                  unosParametros = new SqlParameter[9];

                  unosParametros[0] = new SqlParameter("@Id", System.Data.SqlDbType.VarChar);
                  unosParametros[0].Value = Session["IDMODI"].ToString();


                  unosParametros[1] = new SqlParameter("@Dias", System.Data.SqlDbType.DateTime);
                  unosParametros[1].Value = DateTime.Today.ToShortDateString();

                  unosParametros[2] = new SqlParameter("@Embarcado", System.Data.SqlDbType.Char);
                  unosParametros[2].Value = "0";

                  unosParametros[3] = new SqlParameter("@Piso", System.Data.SqlDbType.VarChar);
                  unosParametros[3].Value = "0";

                  unosParametros[4] = new SqlParameter("@FechaEntrega", System.Data.SqlDbType.VarChar);
                  unosParametros[4].Value = "0000000000";

                  unosParametros[5] = new SqlParameter("@Observa", System.Data.SqlDbType.VarChar);
                  unosParametros[5].Value = "Item Saldado por Compras";

                  unosParametros[6] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                  unosParametros[6].Value = Session["Usr"].ToString();

                  unosParametros[7] = new SqlParameter("@NroOc", System.Data.SqlDbType.VarChar);
                  unosParametros[7].Value = txtOrdenCompra.Text;

                  unosParametros[8] = new SqlParameter("@Item", System.Data.SqlDbType.VarChar);
                  unosParametros[8].Value = txtItem.Text;




                  unAcceso.AbrirConexion();
                  unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
              }
              finally
              {
                  unAcceso.CerrarConexion();

              }
          }
    
    

        private void ActualizarDatos(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

          


            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@ItemId", System.Data.SqlDbType.VarChar);
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
                GridViewRow row = gwGrilla.SelectedRow;
                HiddenFieldError_ModalPopupExtender.Show();


                Session["IDMODI"] = this.gwGrilla.DataKeys[index].Values[0].ToString();

                string sPendiente = gwGrilla.DataKeys[index].Values[4].ToString();
               

                txtProveedor.Text = this.gwGrilla.DataKeys[index].Values[1].ToString();
                txtOrdenCompra.Text = this.gwGrilla.DataKeys[index].Values[2].ToString();
                txtItem.Text = this.gwGrilla.DataKeys[index].Values[3].ToString();
                txtKilosOri.Text = (Convert.ToInt32(gwGrilla.DataKeys[index].Values[4])).ToString();
                txtKilosPend.Text = (Convert.ToInt32(gwGrilla.DataKeys[index].Values[5])).ToString();
            

            }
        }

        protected void ButtonVer_Click(object sender, EventArgs e)
        {
            this.TraerGrilla(gwGrilla, "dbo.SP_COM_GestionOCPendientes");
        }

      

     

       
       
    }

       
}
