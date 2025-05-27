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
    public partial class COM_AutorizacionRequerimientos : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["Accede"] = "NO";
                Session["Grupo"] = Request.QueryString["Parametro"];


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
                    this.TraerGrilla(gwGrilla, "dbo.SP_COM_AutorizarRequerimientoCabecera");
                }
            }
        
        }

      

        private void TraerGrilla(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;
               
            

            try
            {
                unosParametros = new SqlParameter[1];


                unosParametros[0] = new SqlParameter("@Grupo", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt32(Session["Grupo"]);
             
               
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

        private void TraerGrillaDetalle(GridView unGrid, string nombreStored, string sID)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[1];


                unosParametros[0] = new SqlParameter("@bo_extension_id", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = sID;




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

        private void InsertarDatos(string nombreSP, int iRespuesta)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlCommand cmd = new SqlCommand(nombreSP);

            try
            {
                unosParametros = new SqlParameter[5];

                unosParametros[0] = new SqlParameter("@Requerimiento_ID", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["IDRequerimiento"].ToString();

                unosParametros[1] = new SqlParameter("@FlagOrigen_ID", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = Session["FlagOrigen"].ToString();

                unosParametros[2] = new SqlParameter("@OTE", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = Session["OTE"].ToString();

                unosParametros[3] = new SqlParameter("@Respuesta", System.Data.SqlDbType.Int);
                unosParametros[3].Value = iRespuesta;

                unosParametros[4] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[4].Value = Session["Usr"].ToString();
               

              


                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(cmd, unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }
    
      


        protected void gwGrilla_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Detalle")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                string sID = (this.gwGrilla.DataKeys[index].Values[0]).ToString();
                //gwGrilla.Visible = false;
                Panel1.Visible = true;
                this.TraerGrillaDetalle(gwGrillaDetalle, "dbo.SP_COM_AutorizarRequerimientoDetalle", sID);


                lblDetalle1.Text = (this.gwGrilla.DataKeys[index].Values[1]).ToString();
                Session["OTE"] = this.gwGrilla.DataKeys[index].Values[2].ToString();
                Session["FlagOrigen"] = this.gwGrilla.DataKeys[index].Values[3].ToString();
                Session["IDRequerimiento"] = this.gwGrilla.DataKeys[index].Values[4].ToString();
                

                
            }
           
        }

        protected void btnCerrar_Click(object sender, EventArgs e)
        {
            int iRespuesta = 1;
            this.InsertarDatos("SP_VT_InsertarAutorizacionesRequerimientos", iRespuesta);
            this.TraerGrilla(gwGrilla, "dbo.SP_COM_AutorizarRequerimientoCabecera");
            Panel1.Visible = false;
            gwGrilla.Visible = true;
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Panel1.Visible = false;
            gwGrilla.Visible = true;
        }

        protected void btnCerrar0_Click(object sender, EventArgs e)
        {
            int iRespuesta = 0;
            this.InsertarDatos("SP_VT_InsertarAutorizacionesRequerimientos",  iRespuesta);
            this.TraerGrilla(gwGrilla, "dbo.SP_COM_AutorizarRequerimientoCabecera");
            Panel1.Visible = false;
            gwGrilla.Visible = true;
        }
      

    }

       
}
