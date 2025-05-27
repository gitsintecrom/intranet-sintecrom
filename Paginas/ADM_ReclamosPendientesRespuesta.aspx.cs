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
using  System.Web.UI.HtmlControls;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;





namespace SintecromNet.Paginas
{
    public partial class ADM_ReclamosPendientesRespuesta : System.Web.UI.Page
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

                    if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES") || group == ("DOMINIOW_RECEPCION"))
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
                    this.TraerGrilla(gwGrilla, "dbo.SP_ADM_TraerReclamoPendientesRespuesta");

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

    
      


        private void ActualizarDatos(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Reclamo", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt32( Session["Numero"]);

               
                

                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

      
       

     
       

        protected void gwGrilla_SelectedIndexChanged(object sender, EventArgs e)
        {

                      
        }

        
        protected void Button2_Click(object sender, EventArgs e)
        {
           
        }

      
      
        protected void btnAgregar_Click(object sender, EventArgs e)
        {
           
        }

     
     

        protected void gwGrilla_RowCommand(object sender, GridViewCommandEventArgs e)
        {
          

            if (e.CommandName == "Informe")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                Panel4.Visible = true;
                Panel5.Visible = true;
                Session["Numero"] = this.gwGrilla.DataKeys[index].Values[0].ToString();
                string sCliente = this.gwGrilla.DataKeys[index].Values[7].ToString();
                Session["Cliente"] = this.gwGrilla.DataKeys[index].Values[7].ToString();
                Label26.Text = "Informe de Reclamo Número:" + " " + Session["Numero"].ToString() + " " + "Cliente:" + " " + sCliente;

                this.TraerEnvio("dbo.SP_REC_TraerEnvioRespuestaReclamos");
            }

            if (e.CommandName == "Enviar")
            {

                int index = Convert.ToInt32(e.CommandArgument);
                Panel4.Visible = true;
                Panel5.Visible = true;
                Session["Numero"] = this.gwGrilla.DataKeys[index].Values[0].ToString();
                string sCliente = this.gwGrilla.DataKeys[index].Values[7].ToString();
                Label26.Text = "Informe de Reclamo Número:" + " " + Session["Numero"].ToString() + " " + "Cliente:" + " " + sCliente;
                this.ActualizarDatos("SP_ADM_EditarEnvioReclamo");
                this.TraerGrilla(gwGrilla, "dbo.SP_ADM_TraerReclamoPendientesRespuesta");

            }          
           
        }

        private void TraerEnvio(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");



            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Reclamo", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt16(Session["Numero"]);


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreSP), unosParametros);
                if (unDS == null || unDS.Tables.Count == 0 || unDS.Tables[0].Rows.Count == 0)
                {
                    //Button7.Enabled = false;

                    //txtCausaE.Text = "";
                    //txtCorreccionE.Text = "";
                    //txtKilosAceptadosE.Text = "0";
                    //txtSACE.Text = "0";
                }
                else
                {
                    lblMaterial.Text = (unDS.Tables[0].Rows[0]["Material"]).ToString();
                    lblCaracteristicas.Text = (unDS.Tables[0].Rows[0]["Caracteristicas"]).ToString();
                    lblRemito.Text = (unDS.Tables[0].Rows[0]["NroRemito"]).ToString();
                    lblSL.Text = (unDS.Tables[0].Rows[0]["SerieLote"]).ToString();
                    lblReclamoExterno.Text = (unDS.Tables[0].Rows[0]["ReclamoExterno"]).ToString();
                    lblContacto.Text = (unDS.Tables[0].Rows[0]["Contacto"]).ToString();
                    lblEmail.Text = (unDS.Tables[0].Rows[0]["Email"]).ToString();
                    lblCantidad.Text = (unDS.Tables[0].Rows[0]["Cantidad"]).ToString();
                    lblMotivo.Text = (unDS.Tables[0].Rows[0]["Motivo"]).ToString();
                    lblEmite.Text = (unDS.Tables[0].Rows[0]["Emite"]).ToString();
                    lblObservaciones.Text = (unDS.Tables[0].Rows[0]["Observaciones"]).ToString();
                    lblCausa.Text = (unDS.Tables[0].Rows[0]["Causa"]).ToString();
                    lblCorreccion.Text = (unDS.Tables[0].Rows[0]["Correcion"]).ToString();
                    lblKilosAceptados.Text = (unDS.Tables[0].Rows[0]["KilosAceptados"]).ToString();
                    lblFechaRespuesta.Text = Convert.ToDateTime((unDS.Tables[0].Rows[0]["FechaRespuesta"]).ToString()).ToShortDateString();
                    lblSAC.Text = (unDS.Tables[0].Rows[0]["SAC"]).ToString();
                    lblEstado.Text = (unDS.Tables[0].Rows[0]["Estado"]).ToString();
                    lblFechaHoy.Text = DateTime.Now.ToShortDateString();
                }

            }
            finally
            {
                unAcceso.CerrarConexion();

            }

        }



      

        protected void Button5_Click(object sender, EventArgs e)
        {

        }

        protected void Button8_Click(object sender, EventArgs e)
        {

        }

        protected void ImageButton3_Click(object sender, ImageClickEventArgs e)
        {
            Panel4.Visible = false;
            Panel5.Visible = false;
        }

      

        protected void gwGrilla_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
               
            }
        }

   
     

        protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
        {
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=Reclamo" + Session["Numero"] + Session["Cliente"] + ".pdf");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            Panel4.RenderControl(hw);
            StringReader sr = new StringReader(sw.ToString());
            Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 100f, 0f);
            HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
            PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
            pdfDoc.Open();
            htmlparser.Parse(sr);
            pdfDoc.Close();
            Response.Write(pdfDoc);
            Response.End();
        }

        protected void gwGrilla_RowDataBound1(object sender, GridViewRowEventArgs e)
        {

        }

      

       
     

    }

       
}
