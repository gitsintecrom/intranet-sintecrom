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
    public partial class VT_ReservasGestion : System.Web.UI.Page
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

                    if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES") || group == ("DOMINIOW_VENTAS") || group == ("DOMINIOW_AUTORIZACION_COMERCIAL"))
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

                    this.TraerGrilla(gwGrilla, "dbo.SP_VT_TraerReservasMP");
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
       

        private void ActualizarEstado(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[8];

                unosParametros[0] = new SqlParameter("@DepositoOri", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = "8CF45527-8BE8-4D14-BE37-5D5B44BF2878";

                unosParametros[1] = new SqlParameter("@Producto_ID", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = Session["PRODUCTO_ID"].ToString();

                unosParametros[2] = new SqlParameter("@Serie_ID", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = Session["SERIE_ID"].ToString();

                unosParametros[3] = new SqlParameter("@Lote_ID", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = Session["LOTE_ID"].ToString();

                unosParametros[4] = new SqlParameter("@Cantidad", System.Data.SqlDbType.Int);
                unosParametros[4].Value = Convert.ToInt32(txtKilos.Text);

                unosParametros[5] = new SqlParameter("@DepositoDes", System.Data.SqlDbType.VarChar);
                unosParametros[5].Value = Session["DEPOSITODES"].ToString();

                unosParametros[6] = new SqlParameter("@Detalle", System.Data.SqlDbType.VarChar);
                unosParametros[6].Value = "Cancelacion Reserva";

                unosParametros[7] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[7].Value = Session["Usr"].ToString();


               

              
                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreStored), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

        private void ActualizarFecha(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@Lote_ID", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["LOTE_ID"].ToString();

                unosParametros[1] = new SqlParameter("@FechaHasta", System.Data.SqlDbType.DateTime);
                unosParametros[1].Value = Convert.ToDateTime(TextBoxFin.Text);

                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreStored), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }



        protected void gwGrilla_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            

            if (e.CommandName == "Estado")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                

                Session["Lote_ID"] = (this.gwGrilla.DataKeys[index].Values[0]).ToString();
                Session["SERIE_ID"] = (this.gwGrilla.DataKeys[index].Values[1]).ToString();
                Session["PRODUCTO_ID"] = (this.gwGrilla.DataKeys[index].Values[2]).ToString();
                Session["DEPOSITODES"] = (this.gwGrilla.DataKeys[index].Values[3]).ToString();
                txtCliente.Text = (this.gwGrilla.DataKeys[index].Values[4]).ToString();
                txtSL.Text = (this.gwGrilla.DataKeys[index].Values[5]).ToString().Substring(0,12);
                txtKilos.Text = (this.gwGrilla.DataKeys[index].Values[6]).ToString();


                gwGrilla.Visible = false;
                EditarPrecio.Visible = true;                

            }
            if (e.CommandName == "Modificar")
            {
                int index = Convert.ToInt32(e.CommandArgument);


                Session["Lote_ID"] = (this.gwGrilla.DataKeys[index].Values[0]).ToString();
                Session["SERIE_ID"] = (this.gwGrilla.DataKeys[index].Values[1]).ToString();
                Session["PRODUCTO_ID"] = (this.gwGrilla.DataKeys[index].Values[2]).ToString();
                Session["DEPOSITODES"] = (this.gwGrilla.DataKeys[index].Values[3]).ToString();


                txtClientefe.Text = (this.gwGrilla.DataKeys[index].Values[4]).ToString();
                txtSLfe.Text = (this.gwGrilla.DataKeys[index].Values[5]).ToString().Substring(0, 12);
                txtKilosfe.Text = (this.gwGrilla.DataKeys[index].Values[6]).ToString();
                TextBoxFin.Text = (this.gwGrilla.DataKeys[index].Values[7]).ToString();


                gwGrilla.Visible = false;
                EditarFecha.Visible = true;

            }

        }    



        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            this.ActualizarEstado("dbo.SP_VT_EditarReservas");

            gwGrilla.Visible = true;
            EditarPrecio.Visible = false;
            this.TraerGrilla(gwGrilla, "dbo.SP_VT_TraerReservasMP");
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            gwGrilla.Visible = true;
            EditarPrecio.Visible = false;
        }

        protected void btnAceptarf_Click(object sender, EventArgs e)
        {
            this.ActualizarFecha("dbo.SP_VT_EditarFechaReserva");

            gwGrilla.Visible = true;
            EditarFecha.Visible = false;
            this.TraerGrilla(gwGrilla, "dbo.SP_VT_TraerReservasMP");
        }
    }

       
}
