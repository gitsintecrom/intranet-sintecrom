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




namespace SintecromNet.Paginas
{
    public partial class PROD_ProducidoSlitterEmbalaje : System.Web.UI.Page
    {

        decimal dTotalSobreOrden = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["Accede"] = "NO";
               

                IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                foreach (IdentityReference i in irc)
                {
                    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                    if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES") || group == ("DOMINIOW_PRODUCCION"))
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
                    this.CargarCombo();
                    

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
                unosParametros = new SqlParameter[4];

                unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = TextBoxIni.Text;

                if (TextBoxFin.Text != "")
                {
                    DateTime dHasta = Convert.ToDateTime(TextBoxFin.Text, new System.Globalization.CultureInfo("es-ES"));
                    dHasta = dHasta.AddDays(1);
                    unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                    unosParametros[1].Value = dHasta.ToShortDateString();
                    
                }
                else
                {
                    unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                    unosParametros[1].Value = TextBoxFin.Text;
                }

                unosParametros[2] = new SqlParameter("@Familia", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = ddFamilia.SelectedValue;

                unosParametros[3] = new SqlParameter("@Maquina", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = ddMaquina.SelectedValue;
                
             
                
                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);
                

                unGrid.DataSource = unDS;

                unGrid.DataBind();
                //DataTable dt = unDS.Tables[0].Copy();


                //Session["Tabla"] = dt;

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

         private void CargarCombo()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_TraerFamilias"));

                ddFamilia.DataSource = unDS;
                ddFamilia.DataValueField = "Codigo";
                ddFamilia.DataTextField = "Descripcion";
                ddFamilia.DataBind();
                ddFamilia.Items.Insert(0, new ListItem("Seleccione...", ""));

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

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= SlitterAembalaje.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
            gwGrilla.Visible = false;
        }

    



        protected void gwGrilla_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //if (e.CommandName == "Select")
            //{

            //    int index = Convert.ToInt32(e.CommandArgument);


               
            //    Session["SerieO"] = this.gwGrilla.DataKeys[index].Values[0].ToString();
            //    Session["SerieC"] = this.gwGrilla.DataKeys[index].Values[1].ToString();
            //    Session["NotaP"] = this.gwGrilla.DataKeys[index].Values[2].ToString();
            //    Session["NotaC"] = this.gwGrilla.DataKeys[index].Values[3].ToString();

            //}
        }

        protected void gwGrilla_SelectedIndexChanged(object sender, EventArgs e)
        {      
           

           
        }

        protected void gwGrilla_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

               

                if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Kilos_SobreOrden").ToString()))
                {
                    dTotalSobreOrden += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Kilos_SobreOrden"));
                }
               

            }
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                //e.Row.BackColor = Color.Black;
                //e.Row.ForeColor = Color.White;
                e.Row.Cells[0].Text = "Totales:";
                
                //e.Row.Cells[10].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[4].Text = dTotalSobreOrden.ToString("0.00");
                e.Row.Cells[4].HorizontalAlign = HorizontalAlign.Center;

            }
           
        }

     
      

        //protected void btnBuscar_Click(object sender, EventArgs e)
        //{
        //    btnExcel.Visible = true;
        //    this.TraerGrilla(gwGrilla, "SP_PROD_TraerProducidoSlitterEmbajale");

           
        //}

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            LinkButton2.Visible = true;
            this.TraerGrilla(gwGrilla, "SP_PROD_TraerProducidoSlitterEmbajale");

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

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= SlitterAembalaje.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
            gwGrilla.Visible = false;
        } 
     

    }

       
}
