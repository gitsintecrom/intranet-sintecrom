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
    public partial class ADM_ReclamosPendientesNC : System.Web.UI.Page
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

                    if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES") || group == ("DOMINIOW_ADMINISTRACION"))
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
                    this.TraerGrilla(gwGrilla, "dbo.SP_ADM_TraerReclamosNC");

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

        //protected void gwGrilla_RowDataBound(object sender, GridViewRowEventArgs e)
        //{
        //      if (e.Row.RowType == DataControlRowType.DataRow)
        //        {
        //            string item = e.Row.Cells[0].Text;
        //            foreach (Button button in e.Row.Cells[9].Controls.OfType<Button>())
        //            {
        //                if (button.CommandName == "Aprobar")
        //                {
        //                    button.Attributes["onclick"] = "if(!confirm('Esta Seguro de Aprobar La Nota de Crédito para el Reclamo " + item + "?')){ return false; };";
        //                }

                      
        //            }
        //            //foreach (Button button in e.Row.Cells[10].Controls.OfType<Button>())
        //            //{
                      
        //            //    if (button.CommandName == "Rechazar")
        //            //    {
        //            //        button.Attributes["onclick"] = "if(!confirm('Esta Seguro de Rechazar La Nota de Crédito para el Reclamo " + item + "?')){ return false; };";
        //            //    }
        //            //}
        //        }
        //}

        protected void Button2_Click1(object sender, EventArgs e)
        {
            Panel1.Visible = false;
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

      
      
        protected void btnAgregar_Click(object sender, EventArgs e)
        {
           
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


      

        private void EditarReclamoNC(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");



            try
            {
                unosParametros = new SqlParameter[3];

                unosParametros[0] = new SqlParameter("@Reclamo", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt32(Session["Numero"]);

                unosParametros[1] = new SqlParameter("@NC", System.Data.SqlDbType.Int);
                unosParametros[1].Value = 3;

                unosParametros[2] = new SqlParameter("@Cantidad", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = txtReclamoExterno.Text.Trim();


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
          

            if (e.CommandName == "NC")
            {


                int index = Convert.ToInt32(e.CommandArgument);

                Session["Numero"] = this.gwGrilla.DataKeys[index].Values[0].ToString();
                string sCliente = this.gwGrilla.DataKeys[index].Values[7].ToString();
                Label1.Text = "Reclamo:" + " " + Session["Numero"].ToString() + " " + "Cliente:" + " " + sCliente;

                Panel1.Visible = true;
                


            }

           

            //if (e.CommandName == "NC")
            //{


            //    int index = Convert.ToInt32(e.CommandArgument);

            //    Session["Numero"] = this.gwGrilla.DataKeys[index].Values[0].ToString();
            //    Session["NC"] = 2;

            //    this.EditarReclamoNC("dbo.SP_REC_EditarNCReclamo");
            //    this.TraerGrilla(gwGrilla, "dbo.SP_REC_TraerReclamosNC");


            //}

           
        }



        protected void gwSeguimiento_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        protected void gwSeguimiento_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }

     

      

        protected void Button5_Click(object sender, EventArgs e)
        {

        }

        protected void Button8_Click(object sender, EventArgs e)
        {

        }

        protected void ImageButton3_Click(object sender, ImageClickEventArgs e)
        {
            //Panel4.Visible = false;
            //Panel5.Visible = false;
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

        protected void gwGrilla_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
               
            }
        }

        protected void gwGrilla_RowDataBound1(object sender, GridViewRowEventArgs e)
        {
            //string item = e.Row.Cells[0].Text;
            //foreach (Button button in e.Row.Cells[7].Controls.OfType<Button>())
            //{
            //    if (button.CommandName == "Aprobar")
            //    {
            //        button.Attributes["onclick"] = "if(!confirm('Esta Seguro de Aprobar La Nota de Crédito para el Reclamo " + item + "?')){ return false; };";
            //    }


            //}
            //foreach (Button button in e.Row.Cells[10].Controls.OfType<Button>())
            //{

            //    if (button.CommandName == "Rechazar")
            //    {
            //        button.Attributes["onclick"] = "if(!confirm('Esta Seguro de Rechazar La Nota de Crédito para el Reclamo " + item + "?')){ return false; };";
            //    }
            //}
        }

        protected void Button7_Click(object sender, EventArgs e)
        {
            this.EditarReclamoNC("dbo.SP_ADM_EditarNCReclamo");
            this.TraerGrilla(gwGrilla, "dbo.SP_ADM_TraerReclamosNC");
            Panel1.Visible = false;

        }

      

       
     

    }

       
}
