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
    public partial class PROD_IngresoPlanta2 : System.Web.UI.Page
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
                    this.TraerGrilla(gwGrilla, "SP_I_TraerIngresosPlantaII");

                }
            }
        
        }

      

        private void TraerGrilla(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;
          
            

            try
            {
                unosParametros = new SqlParameter[2];

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

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= IngresosPlanta2.xls");
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
            //if (e.Row.RowType == DataControlRowType.DataRow)
            //{               
            //    e.Row.Attributes.Add("onMouseOver", "this.style.background='#f2d9d9';this.style.cursor='pointer'");

            //    e.Row.Attributes.Add("onMouseOut", "this.style.background='#ffffff'");


            //    e.Row.Attributes["onClick"] = ClientScript.GetPostBackClientHyperlink(this.gwGrilla, "Select$" + e.Row.RowIndex);
            //    e.Row.ToolTip = "Haga Click para Seleccionar la línea.";

            //}
           
        }

     
      

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            this.TraerGrilla(gwGrilla, "dbo.SP_I_TraerIngresosPlantaII");

           
        }


       

      
       

       

      
       
       


           

      
      

       
     

    }

       
}
