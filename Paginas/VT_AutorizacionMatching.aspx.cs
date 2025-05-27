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
    public partial class VT_AutorizacionMatching : System.Web.UI.Page
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

                    if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES") || group == ("DOMINIOW_AUTORIZACION_COMERCIAL") )
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
                    this.TraerGrilla(gwGrilla, "dbo.SP_VT_AutorizarMatchingsCabecera");
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
              

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerGrillaDetalle(GridView unGrid, string nombreStored,int iNumeroMatching)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[1];


                unosParametros[0] = new SqlParameter("@NroMatching", System.Data.SqlDbType.Int);
                unosParametros[0].Value = iNumeroMatching;




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
                unosParametros = new SqlParameter[4];

                unosParametros[0] = new SqlParameter("@Matching_ID", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["Matching_ID"].ToString();

                unosParametros[1] = new SqlParameter("@FlagOrigen_ID", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = Session["FlagOrigen"].ToString();

                unosParametros[2] = new SqlParameter("@Respuesta", System.Data.SqlDbType.Int);
                unosParametros[2].Value = iRespuesta;

                unosParametros[3] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = Session["Usr"].ToString();
               

              


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
                int iNroMatching = Convert.ToInt32(this.gwGrilla.DataKeys[index].Values[0]);
                //gwGrilla.Visible = false;
                Panel1.Visible = true;
                this.TraerGrillaDetalle(gwGrillaDetalle, "dbo.SP_SC_ConsultaMatchingsDetalle", iNroMatching);
               
              
                lblDetalle1.Text = iNroMatching.ToString();
                Label1.Text = this.gwGrilla.DataKeys[index].Values[3].ToString();
                Session["Matching_ID"] = this.gwGrilla.DataKeys[index].Values[1].ToString();
                Session["FlagOrigen"] = this.gwGrilla.DataKeys[index].Values[2].ToString();
                

                
            }
           
        }

        protected void btnCerrar_Click(object sender, EventArgs e)
        {
            int iRespuesta = 1;
            this.InsertarDatos("SP_VT_InsertarAutorizacionesMatching", iRespuesta);
            this.TraerGrilla(gwGrilla, "dbo.SP_VT_AutorizarMatchingsCabecera");
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
            this.InsertarDatos("SP_VT_InsertarAutorizacionesMatching",  iRespuesta);
            this.TraerGrilla(gwGrilla, "dbo.SP_VT_AutorizarMatchingsCabecera");
            Panel1.Visible = false;
            gwGrilla.Visible = true;
        }
      

    }

       
}
