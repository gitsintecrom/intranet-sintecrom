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
    public partial class CAL_EstadoReclamos : System.Web.UI.Page
    {
       

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
               
            }
        
        }

      

        private void TraerGrilla(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;
          
            

            try
            {
                unosParametros = new SqlParameter[3];
               
                
                unosParametros[0] = new SqlParameter("@Estado", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = DropDownList1.SelectedValue;

                if (!String.IsNullOrEmpty(txtReclamo.Text))
                {
                    unosParametros[1] = new SqlParameter("@Reclamo", System.Data.SqlDbType.Int);
                    unosParametros[1].Value = Convert.ToInt32(txtReclamo.Text);
                }
                else
                {
                    unosParametros[1] = new SqlParameter("@Reclamo", System.Data.SqlDbType.Int);
                    unosParametros[1].Value = 0;
                }
               

                unosParametros[2] = new SqlParameter("@Cliente", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = txtCliente.Text;
                               
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

        private void TraerGrillaDetalle(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;



            try
            {
                unosParametros = new SqlParameter[1];


                unosParametros[0] = new SqlParameter("@ID", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt32(Session["Numero"]);


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
      


        private void ActualizarDatos(string nombreSP, string sEstado)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@Numero", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt32( Session["Numero"]);

                
                unosParametros[1] = new SqlParameter("@Estado", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = sEstado;
                

                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

      
        protected void btnExcel_Click(object sender, ImageClickEventArgs e)
        {
           
            StringBuilder sb = new StringBuilder();
            StringWriter sw = new StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            Page page = new Page();
            HtmlForm form = new HtmlForm();

            gwGrilla.EnableViewState = false;
            page.EnableEventValidation = false;
            page.DesignerInitialize();
            page.Controls.Add(form);
            form.Controls.Add(gwGrilla);
            page.RenderControl(htw);

            Page.Response.Clear();
            Page.Response.Buffer = true;
            Page.Response.ContentType = "application/vnd.ms-excel";

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= FactLS.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
            gwGrilla.Visible = false;
        }     


       

      

     
      

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            this.TraerGrilla(gwGrilla, "dbo.SP_TraerReclamosTodos");

            LinkButton2.Visible = true;          
        }

       

        protected void gwGrilla_SelectedIndexChanged(object sender, EventArgs e)
        {

            //this.TraerDetalle(GridView1, "dbo.SP_TraerDetalleFacturacionLS");
            //if (Convert.ToInt16( Session["Estado"]) == 1)
            //{
            //    btnEjecutar.Visible = false;
            //}
            //else
            //{
            //    btnEjecutar.Visible = true;

            //}
           
        }

        protected void gwGrilla_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //e.Row.Attributes.Add("onMouseOver", "this.style.background='#f2d9d9';this.style.cursor='pointer'");

                //e.Row.Attributes.Add("onMouseOut", "this.style.background='#ffffff'");


                //e.Row.Attributes["onClick"] = ClientScript.GetPostBackClientHyperlink(this.gwGrilla, "Select$" + e.Row.RowIndex);
                //e.Row.ToolTip = "Haga Click en el Numero de Reclamo para Visualizar el Detalle.";

            }
        }

        protected void Button2_Click1(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            LinkButton2.Visible = true;
          
        }

        protected void btnEjecutar_Click(object sender, EventArgs e)
        {
            this.ActualizarDatos("dbo.SP_ModificarEstadoReclamo", "En Proceso");
            this.TraerGrilla(gwGrilla, "dbo.SP_TraerReclamos");


            LinkButton2.Visible = true;
           
        }

       

        protected void Button1_Click1(object sender, EventArgs e)
        {
            this.ActualizarDatos("dbo.SP_ModificarEstadoReclamo", "Anulado");
            this.TraerGrilla(gwGrilla,  "dbo.SP_TraerReclamosTodos");


            LinkButton2.Visible = true;
        }

        private void CargarGrillaAdjuntos(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Numero", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Session["Numero"].ToString();


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

        private void CargarGrillaSeguimiento(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@ID", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt32(Session["Numero"]);


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

        protected void Button2_Click(object sender, EventArgs e)
        {
           
        }

        protected void gwAdjuntos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {

                int index = Convert.ToInt32(e.CommandArgument);


                Session["ID"] = this.gwAdjuntos.DataKeys[index].Values[0].ToString();

            }
        }

        protected void gwAdjuntos_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            

            int index = Convert.ToInt32(e.RowIndex);



            Session["ID"] = this.gwAdjuntos.DataKeys[index].Values[0].ToString();

            this.EliminarAdjunto("SP_EliminarImagenesReclamos");
            this.CargarGrillaAdjuntos(gwAdjuntos, "dbo.SP_Traer_ImagenReclamo");

        }

        protected void gwAdjuntos_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gwAdjuntos.SelectedRow;

            string str;
            str = "window.open('CAL_Imagenes.aspx','Titulo','width=500,height=500,sc rollbars=no,resizable=no')";
            Response.Write("<script languaje=javascript>" + str + "</script>");
        }

        protected void gwAdjuntos_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        private void EliminarAdjunto(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@ID", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt32(Session["ID"]);

               

                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }

        }
        protected void btnAgregar_Click(object sender, EventArgs e)
        {
           
        }

        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Panel9.Visible = false;
        }
        private void ActualizaReclamo(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[3];

                unosParametros[0] = new SqlParameter("@Numero", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt16(Session["Numero"]);

                unosParametros[1] = new SqlParameter("@Imagen", System.Data.SqlDbType.Image);
                unosParametros[1].Value = Session["imgInc"];

                unosParametros[2] = new SqlParameter("@Archivo", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = Session["NombreArchivo"].ToString().Trim();


                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }

        }


        private void InsertarRespuestaReclamo(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[6];

                unosParametros[0] = new SqlParameter("@Reclamo", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt16(Session["Numero"]);

                unosParametros[1] = new SqlParameter("@Fecha", System.Data.SqlDbType.DateTime);
                unosParametros[1].Value = DateTime.Now;

                unosParametros[2] = new SqlParameter("@Causa", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = txtCausa.Text.Trim();

                unosParametros[3] = new SqlParameter("@Correccion", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = txtCorreccion.Text.Trim();

                unosParametros[4] = new SqlParameter("@KilosAceptados", System.Data.SqlDbType.Int);
                unosParametros[4].Value = Convert.ToInt32(txtKilosAceptados.Text);

                unosParametros[5] = new SqlParameter("@SAC", System.Data.SqlDbType.Int);
                unosParametros[5].Value = Convert.ToInt32(txtSAC.Text);


                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }

        }

        private void EditarRespuestaReclamo(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[6];

                unosParametros[0] = new SqlParameter("@Reclamo", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt16(Session["Numero"]);

                unosParametros[1] = new SqlParameter("@Fecha", System.Data.SqlDbType.DateTime);
                unosParametros[1].Value = DateTime.Now;

                unosParametros[2] = new SqlParameter("@Causa", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = txtCausa.Text.Trim();

                unosParametros[3] = new SqlParameter("@Correccion", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = txtCorreccion.Text.Trim();

                unosParametros[4] = new SqlParameter("@KilosAceptados", System.Data.SqlDbType.Int);
                unosParametros[4].Value = Convert.ToInt32(txtKilosAceptados.Text);

                unosParametros[5] = new SqlParameter("@SAC", System.Data.SqlDbType.Int);
                unosParametros[5].Value = Convert.ToInt32(txtSAC.Text);


                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }

        }

        private void TraerRespuesta(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            Session["Alta"] = "";


            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Reclamo", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt16(Session["Numero"]);
              

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreSP), unosParametros);
                if (unDS == null || unDS.Tables.Count == 0 || unDS.Tables[0].Rows.Count == 0)
                {
                    //Button4.Text = "Agregar";
                    Session["Alta"] = "A";
                    txtCausa.Text = "";
                    txtCorreccion.Text = "";
                    txtKilosAceptados.Text = "0";
                    txtSAC.Text = "0";
                }
                else
                {
                    txtCausa.Text = (unDS.Tables[0].Rows[0]["Causa"]).ToString(); 
                    txtCorreccion.Text = (unDS.Tables[0].Rows[0]["Correcion"]).ToString();
                    txtKilosAceptados.Text = (unDS.Tables[0].Rows[0]["KilosAceptados"]).ToString();
                    txtSAC.Text = (unDS.Tables[0].Rows[0]["SAC"]).ToString();
                    //Button4.Text = "Modificar";
                    Session["Alta"] = "M";

                }

                //int iMensajes = (Convert.ToInt32(unDS.Tables[0].Rows[0]["Mensajes"]));
            }
            finally
            {
                unAcceso.CerrarConexion();

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

     

        private Boolean ValidarExtension(string sExtension)
        {
            Boolean verif = false;
            switch (sExtension)
            {
                case ".jpg":
                case ".jpeg":
                case ".png":
                case ".gif":
                case ".bmp":
                case ".JPG":
                case ".JPEG":
                case ".PNG":
                case ".GIF":
                case ".BMP":
                    verif = true;
                    break;
                default:
                    verif = false;
                    break;
            }
            return verif;
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            Panel9.Visible = true;
            lblReclamo.Text = "Reclamo:" + " " + Session["Numero"].ToString();

            this.CargarGrillaAdjuntos(gwAdjuntos, "dbo.SP_Traer_ImagenReclamo");
        }

       
      

        protected void gwGrilla_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Detalle")
            {

                int index = Convert.ToInt32(e.CommandArgument);

                Session["Numero"] = this.gwGrilla.DataKeys[index].Values[0].ToString();
                string sCliente = this.gwGrilla.DataKeys[index].Values[7].ToString();
                Label1.Text = "Reclamo:" + " " + Session["Numero"].ToString() + " " + "Cliente:" + " " + sCliente;
                //txtCaracteristicas.Text = this.gwGrilla.DataKeys[index].Values[2].ToString();
                txtEmite.Text = this.gwGrilla.DataKeys[index].Values[4].ToString();
                txtMotivo.Text = this.gwGrilla.DataKeys[index].Values[3].ToString();
                txtObservaciones.Text = this.gwGrilla.DataKeys[index].Values[5].ToString();
                txtReclamoExterno.Text = this.gwGrilla.DataKeys[index].Values[6].ToString();
                this.TraerGrillaDetalle(GridView1, "dbo.SP_REC_TraerReclamosRemitos");

                HiddenFieldError_ModalPopupExtender.Show();


            }
            if (e.CommandName == "Gestion")
            {


                int index = Convert.ToInt32(e.CommandArgument);

                Session["Numero"] = this.gwGrilla.DataKeys[index].Values[0].ToString();
                string sCliente = this.gwGrilla.DataKeys[index].Values[7].ToString();
                //txtFecha.Text = DateTime.Now.ToShortDateString();
                //Label19.Text = "Reclamo:" + " " + Session["Numero"].ToString() + " " + "Cliente:" + " " + sCliente;
                //if (String.IsNullOrEmpty(this.gwGrilla.DataKeys[index].Values[8].ToString()))
                //{
                //    txtResponsable.ReadOnly = false;
                //    txtGrupo.ReadOnly = false;
                //}
                //else
                //{
                //    txtResponsable.Text = this.gwGrilla.DataKeys[index].Values[8].ToString();
                //    txtGrupo.Text = this.gwGrilla.DataKeys[index].Values[9].ToString();
                //    txtResponsable.ReadOnly = true;
                //    txtGrupo.ReadOnly = true;
                //    txtDefiniciones.Focus();


                //}
                this.CargarGrillaSeguimiento(gwSeguimiento, "dbo.SP_REC_TraerSeguimientoReclamos");

                ModalPopupExtender1.Show();

            }

            if (e.CommandName == "Respuesta")
            {


                int index = Convert.ToInt32(e.CommandArgument);

                Session["Numero"] = this.gwGrilla.DataKeys[index].Values[0].ToString();
                string sCliente = this.gwGrilla.DataKeys[index].Values[7].ToString();
                Label23.Text = "Reclamo:" + " " + Session["Numero"].ToString() + " " + "Cliente:" + " " + sCliente;
             
                ModalPopupExtender3.Show();
                this.TraerRespuesta("dbo.SP_TraerRespuestaReclamos");


            }

            if (e.CommandName == "Envio")
            {


                int index = Convert.ToInt32(e.CommandArgument);
                Panel4.Visible = true;
                Panel5.Visible = true;
                Session["Numero"] = this.gwGrilla.DataKeys[index].Values[0].ToString();
                Session["Cliente"] = this.gwGrilla.DataKeys[index].Values[7].ToString();
                string sCliente = this.gwGrilla.DataKeys[index].Values[7].ToString();
                Label26.Text = "Informe de Reclamo Número:" + " " + Session["Numero"].ToString() + " " + "Cliente:" + " " + sCliente;

                this.TraerEnvio("dbo.SP_REC_TraerEnvioRespuestaReclamos");


            }
        }



        protected void gwSeguimiento_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        protected void gwSeguimiento_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }

     

        protected void Button4_Click(object sender, EventArgs e)
        {
            if( Session["Alta"].ToString() == "A")
            {
                this.InsertarRespuestaReclamo("SP_InsertarRespuestaReclamos");

            }
            else
            {
                this.EditarRespuestaReclamo("SP_EditarRespuestaReclamos");
            }
        }

        protected void Button5_Click(object sender, EventArgs e)
        {

        }

        protected void Button8_Click(object sender, EventArgs e)
        {

        }

        protected void Button7_Click(object sender, EventArgs e)
        {
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=Panel.pdf");
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

        protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
        {
            Response.ContentType = "application/pdf";
            //Response.AddHeader("content-disposition", "attachment;filename=Panel.pdf");
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

        protected void ImageButton3_Click(object sender, ImageClickEventArgs e)
        {
            Panel4.Visible = false;
            Panel5.Visible = false;
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            StringBuilder sb = new StringBuilder();
            StringWriter sw = new StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            Page page = new Page();
            HtmlForm form = new HtmlForm();

            gwGrilla.EnableViewState = false;
            page.EnableEventValidation = false;
            page.DesignerInitialize();
            page.Controls.Add(form);
            form.Controls.Add(gwGrilla);
            page.RenderControl(htw);

            Page.Response.Clear();
            Page.Response.Buffer = true;
            Page.Response.ContentType = "application/vnd.ms-excel";

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= FactLS.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
            gwGrilla.Visible = false;
        }

       
     

    }

       
}
