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
    public partial class INV_IngresosPendientesMP : System.Web.UI.Page
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

                    if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES") || group == ("DOMINIOW_AUTORIZACION_COMERCIAL") || group == ("DOMINIOW_SUPPLYCHAIN"))
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
                    this.TraerGrilla(gwGrilla, "dbo.SP_INV_TraerIngresoMP");
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

        private void TraerGrillaDetalle(GridView unGrid, string nombreStored, string sID)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[1];


                unosParametros[0] = new SqlParameter("@itemid", System.Data.SqlDbType.VarChar);
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

        private void EditarDatos(string nombreSP, int iRespuesta)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlCommand cmd = new SqlCommand(nombreSP);

           

            try
            {
                unosParametros = new SqlParameter[3];

                unosParametros[0] = new SqlParameter("@IDAutorizacion", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt32(Session["IDAutorizacion"]);  

                unosParametros[1] = new SqlParameter("@Respuesta", System.Data.SqlDbType.Int);
                unosParametros[1].Value = iRespuesta;

                unosParametros[2] = new SqlParameter("@Autoriza", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = Session["Usr"].ToString();


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
               
                //Label1.Text = this.gwGrilla.DataKeys[index].Values[0].ToString();


                string sID = (this.gwGrilla.DataKeys[index].Values[0]).ToString();
                string sOrigen = (this.gwGrilla.DataKeys[index].Values[1]).ToString();
                gwGrilla.Visible = false;
                Panel1.Visible = true;
                if(sOrigen=="I")
                {
                    this.TraerGrillaDetalle(gwGrillaDetalle, "dbo.SP_INV_TraerDetalleMPPendienteI", sID);

                }
                else
                {
                    this.TraerGrillaDetalle(gwGrillaDetalle, "dbo.SP_INV_TraerDetalleMPPendienteN", sID);

                }
                //this.TraerGrillaDetalle(gwGrillaDetalle, "dbo.SP_VT_AutorizarPedidoDetalleTEST", sID);


                lblDetalle1.Text = "Ingreso Número: " + (this.gwGrilla.DataKeys[index].Values[2]).ToString();
                Label1.Text = "Proveedor: " + this.gwGrilla.DataKeys[index].Values[3].ToString();
                
            }
           
        }

      

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Panel1.Visible = false;
            gwGrilla.Visible = true;
        }

      
      

    }

       
}
