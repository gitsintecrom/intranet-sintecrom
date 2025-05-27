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
    public partial class COM_ParametrosProveedores : System.Web.UI.Page
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
                    this.TraerGrilla(gwGrilla, "dbo.SP_COM_TraerProveedoresaEditar");

                }
              
            }

        
        }

        private void TraerGrilla(GridView unGrid, string nombreStored)
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

    

      


        protected void btnModificar_Click(object sender, EventArgs e)
        {
                this.ActualizarDatos("dbo.SP_COM_EditarProveedor");
                this.TraerGrilla(gwGrilla, "dbo.SP_COM_TraerProveedoresaEditar");         
            
           
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
               

                unosParametros[1] = new SqlParameter("@Dias", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = txtDescripcion.Text;


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

                txtProveedor.Text = this.gwGrilla.DataKeys[index].Values[1].ToString();
                txtDescripcion.Text = this.gwGrilla.DataKeys[index].Values[2].ToString();

            }
        }

        protected void gwGrilla_SelectedIndexChanged(object sender, EventArgs e)
        {
          


           
           
        }

        protected void gwGrilla_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            
        }

     

       
       
    }

       
}
