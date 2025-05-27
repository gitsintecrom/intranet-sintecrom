using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Collections;
using System.Data;
using System.Data.OleDb;
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
using System.Diagnostics;
using Excel = Microsoft.Office.Interop.Excel;




namespace SintecromNet.Paginas
{
    public partial class CAL_SIDPantallaInicial : System.Web.UI.Page
    {
       
        protected void Page_Load(object sender, EventArgs e)
        {

            this.TraerGrilla(gwGrilla, "SP_SID_TraerIndiceSID");

        
        }
      

       

     
        private void TraerGrilla(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;

            try
            {

                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Codigo", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = "PS";

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

        private void TraerGestionAmbiental(string nombreStored, string SCodigo)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;
            string sRuta = "";
            string sHoja = "";

            try
            {

                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Codigo", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = SCodigo;

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);




                sRuta = unDS.Tables[0].Rows[0]["Ruta"].ToString();
                sHoja = unDS.Tables[0].Rows[0]["Hoja"].ToString();

              

                //Excel.Application xlApp = new Excel.Application();
                //Excel.Workbook xlWorkbook = xlApp.Workbooks.Open(sRuta);
                //Excel._Worksheet xlWorksheet = xlWorkbook.Sheets[1];
                //Excel.Range xlRange = xlWorksheet.UsedRange;


                Process.Start(@sRuta);
                //string strFileName;
                //string strExtension;

                //strFileName = Path.GetFileName(sRuta);
                //strExtension = Path.GetExtension(strFileName);

           

                //Response.Buffer = true;
              
                //Response.ContentType = "application/vnd.ms-excel";
                //Response.AddHeader("content-disposition", "attachment;filename=" + strFileName);
              
                //Response.Charset = "";
                //Response.Cache.SetCacheability(HttpCacheability.NoCache);
                //Response.WriteFile(sRuta);
                //Response.End();

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
       

    

        protected void gwGrilla_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Ver")
            {

                int index = Convert.ToInt32(e.CommandArgument);
               String sRuta = this.gwGrilla.DataKeys[index].Values[0].ToString();
               string strFileName;
               string strExtension;

               strFileName = Path.GetFileName(sRuta);
               strExtension = Path.GetExtension(strFileName);

           

               Response.Buffer = true;
               if (strExtension == ".doc" || strExtension == ".docx")
               {
                   Response.ContentType = "application/vnd.ms-word";
                   Response.AddHeader("content-disposition", "attachment;filename=" + strFileName );
               }
               else if (strExtension == ".xls" || strExtension == ".xlsx")
               {
                   Response.ContentType = "application/vnd.ms-excel";
                   Response.AddHeader("content-disposition", "attachment;filename=" + strFileName);
               }
               else if (strExtension == ".pdf")
               {
                   Response.ContentType = "application/pdf";
                   Response.AddHeader("content-disposition", "attachment;filename=" + strFileName);
               }
               Response.Charset = "";
               Response.Cache.SetCacheability(HttpCacheability.NoCache);
               Response.WriteFile(sRuta);
               Response.End();

            }

         
        }

       

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Panel2.Visible = false;
            Panel1.Visible = true;
        }

        protected void gwGrilla_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //Button bAbrir = (Button)e.Row.FindControl("Button1");
                //string url = e.Row.Cells[5].Text;
                //bEstado.op.NavigateUrl = url;
                //hlink.Text = "Read";
            }
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            //this.TraerGestionAmbiental(gwGrilla, "SP_SID_TraerIndiceSID");
            Panel1.Visible = false;
            Panel2.Visible = true;

        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            this.TraerGestionAmbiental("SP_SID_TraerIndiceSID", "GA02");
        }

        protected void LinkButton4_Click(object sender, EventArgs e)
        {

        }

        protected void LinkButton5_Click(object sender, EventArgs e)
        {
            //Process.Start("c:\\SID\\ORDEN Y LIMPIEZA\\AMBIENTAL\\Visio-Ciclo de vida Sintecrom (1).pdf");
            this.TraerGestionAmbiental("SP_SID_TraerIndiceSID", "GA01");
        }

        protected void LinkButton6_Click(object sender, EventArgs e)
        {

        }

        protected void LinkButton7_Click(object sender, EventArgs e)
        {

        }

        protected void LinkButton8_Click(object sender, EventArgs e)
        {

        }

       
    }

       
}
