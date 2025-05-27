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
    public partial class CAL_InformeMuestras : System.Web.UI.Page
    {
        public string sVendedor { get; set; }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["Parametro"] != null)
            {
                sVendedor = Request.QueryString["Parametro"];
            }

            if (!IsPostBack)
            {
                Session["Accede"] = "NO";
              


                IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                foreach (IdentityReference i in irc)
                {
                    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                    if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES") || group == ("DOMINIOW_CALIDAD")
                        || group == ("DOMINIOW_AUTORIZACION_COMERCIAL") || group == "DOMINIOW_SUPPLYCHAIN"
                        || group == ("DOMINIOW_VENDEDORES") || group == ("DOMINIOW_PRODUCCION"))
                    {
                        Session["Accede"] = "OK";
                    }

                }
                if (Session["Accede"].ToString() == "NO")
                {
                    Response.Redirect("Restringida.aspx");
                }
               
            }
        
        }

      

        private void TraerGrilla(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;

            DataSet unDS = null;
               
            

            try
            {

                unosParametros = new SqlParameter[3];
                unosParametros[0] = new SqlParameter("@Estado", System.Data.SqlDbType.Int);
                unosParametros[0].Value = ddEstado.SelectedValue;

                unosParametros[1] = new SqlParameter("@Cliente", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = txtCliente.Text;

                unosParametros[2] = new SqlParameter("@Vendedor", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = sVendedor;
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

      
      


        protected void gwGrilla_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Detalle")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                Panel1.Visible = true;
                Panel2.Visible = false;
                lblCliente.Text = this.gwGrilla.DataKeys[index].Values[0].ToString();
                lblEmail.Text = this.gwGrilla.DataKeys[index].Values[2].ToString();
                lblTelefono.Text = this.gwGrilla.DataKeys[index].Values[3].ToString();
                lblRequiereCertificado.Text = this.gwGrilla.DataKeys[index].Values[4].ToString();
                lblEmailCertificado.Text = this.gwGrilla.DataKeys[index].Values[5].ToString();
                lblEmbalaje.Text = this.gwGrilla.DataKeys[index].Values[6].ToString();
                lblPlegado.Text = this.gwGrilla.DataKeys[index].Values[7].ToString();
                lblProfundidad.Text = this.gwGrilla.DataKeys[index].Values[8].ToString();
                lblPintado.Text = this.gwGrilla.DataKeys[index].Values[9].ToString();
                lblAnodizado.Text = this.gwGrilla.DataKeys[index].Values[10].ToString();
                lblPerforado.Text = this.gwGrilla.DataKeys[index].Values[11].ToString();
                lblConformado.Text = this.gwGrilla.DataKeys[index].Values[12].ToString();
                lblObservacionesC.Text = this.gwGrilla.DataKeys[index].Values[13].ToString();
                lblObservacionesP.Text = this.gwGrilla.DataKeys[index].Values[14].ToString();
                lblObservacionesV.Text = this.gwGrilla.DataKeys[index].Values[15].ToString();
                lblComentarios.Text = this.gwGrilla.DataKeys[index].Values[16].ToString();
                lblDomicilio.Text = this.gwGrilla.DataKeys[index].Values[17].ToString();
                lblTransporte.Text = this.gwGrilla.DataKeys[index].Values[18].ToString();
                lblUsoFinal.Text = this.gwGrilla.DataKeys[index].Values[19].ToString();
                lblOrigen.Text = this.gwGrilla.DataKeys[index].Values[20].ToString();
                lblVendedor.Text = this.gwGrilla.DataKeys[index].Values[21].ToString();
                lblEstado.Text = this.gwGrilla.DataKeys[index].Values[22].ToString();
                lblFechaSolicitada.Text = Convert.ToDateTime(this.gwGrilla.DataKeys[index].Values[24].ToString()).ToString("dd/MM/yyyy");
                lblMaterial.Text = this.gwGrilla.DataKeys[index].Values[25].ToString();
                lblSerie.Text = this.gwGrilla.DataKeys[index].Values[26].ToString();
                lblEspesor.Text = this.gwGrilla.DataKeys[index].Values[27].ToString();
                lblAncho.Text = this.gwGrilla.DataKeys[index].Values[28].ToString();
                lblUnidadMedida.Text = this.gwGrilla.DataKeys[index].Values[29].ToString();
                lblLargo.Text = this.gwGrilla.DataKeys[index].Values[31].ToString();
                lblFechaDespacho.Text = this.gwGrilla.DataKeys[index].Values[32].ToString();
                lblAleacion.Text = this.gwGrilla.DataKeys[index].Values[33].ToString();
                lblTemple.Text = this.gwGrilla.DataKeys[index].Values[34].ToString();

                Session["ID"] = Convert.ToInt32(this.gwGrilla.DataKeys[index].Values[1]);

            }
           
        }

        protected void btnCerrar_Click(object sender, EventArgs e)
        {
           
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Panel1.Visible = false;
            Panel2.Visible = true;
        }

    

      

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            this.TraerGrilla(gwGrilla, "dbo.SP_CAL_TraerInformeMuestras");

        }
    }

       
}
