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
    public partial class PROD_RegistroInspeccion : System.Web.UI.Page
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

                    if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES") || group == "DOMINIOW_PRODUCCION" || group == "DOMINIOW_CALIDAD")
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
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;         
            

            try
            {
                unosParametros = new SqlParameter[1];
               
                unosParametros[0] = new SqlParameter("@Lote", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = txtSerie.Text.Trim();

               
               
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

      

        protected void gwGrilla_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                //if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Kilos").ToString()))
                //{
                //    dKilos += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Importe"));
                //}

                //e.Row.Attributes.Add("onMouseOver", "this.style.background='#f2d9d9';this.style.cursor='pointer'");

                //e.Row.Attributes.Add("onMouseOut", "this.style.background='#ffffff'");


                //e.Row.Attributes["onClick"] = ClientScript.GetPostBackClientHyperlink(this.gwGrilla, "Select$" + e.Row.RowIndex);
                //e.Row.ToolTip = "Haga Click para Seleccionar la línea.";

            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                                
                e.Row.Attributes.Add("onMouseOver", "this.style.background='#f2d9d9';this.style.cursor='pointer'");

                e.Row.Attributes.Add("onMouseOut", "this.style.background='#ffffff'");


                //e.Row.Attributes["onClick"] = ClientScript.GetPostBackClientHyperlink(this.gwGrilla, "Select$" + e.Row.RowIndex);
                //e.Row.ToolTip = "Haga Click para Seleccionar la línea.";

            }
           
        }

        protected void ButtonVer_Click(object sender, EventArgs e)
        {
            this.TraerGrilla(gwGrilla, "dbo.SP_PROD_RegistroInspeccion");
            //btnExcel.Visible = true;
        }

      

        protected void gwGrilla_RowDataBound1(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                            
               
                e.Row.Attributes.Add("onMouseOver", "this.style.background='#f2d9d9';this.style.cursor='pointer'");

                e.Row.Attributes.Add("onMouseOut", "this.style.background='#ffffff'");


                //e.Row.Attributes["onClick"] = ClientScript.GetPostBackClientHyperlink(this.gwGrilla, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Haga Click En Detalle para Seleccionar la línea.";

            }
      
        }

        protected void gwGrilla_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Pasadas")
            {

                int index = Convert.ToInt32(e.CommandArgument);

                Session["Operacion_ID"] = this.gwGrilla.DataKeys[index].Values[0].ToString();
                Session["Calidad"] = this.gwGrilla.DataKeys[index].Values[1].ToString();

               

                    Panel1.Visible = true;
                    gwGrilla.Visible = false;
                    lblCalidad.Text = this.gwGrilla.DataKeys[index].Values[1].ToString();
                    this.TraerPasadas("SP_PROD_RegistroInspeccionPasadas");
                }

           

            }

        private void TraerPasadas(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNET");
            SqlParameter[] unosParametros = null;

            DataSet unDS1 = null;

                      try
            {

                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Operacion_ID", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["Operacion_ID"].ToString().Trim();


                unAcceso.AbrirConexion();
                unDS1 = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);



                GridView1.DataSource = unDS1;
                GridView1.DataBind();



            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        
        }

         private void TraerAnchos(string nombreStored)
         {
             Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNET");
             SqlParameter[] unosParametros = null;

             DataSet unDS1 = null;

             try
             {

                 unosParametros = new SqlParameter[2];

                 unosParametros[0] = new SqlParameter("@Operacion_ID", System.Data.SqlDbType.VarChar);
                 unosParametros[0].Value = Session["Operacion_ID"].ToString().Trim();

                 unosParametros[1] = new SqlParameter("@Numero", System.Data.SqlDbType.Int);
                 unosParametros[1].Value = Convert.ToInt16(Session["Numero"]);

                 

                

                 unAcceso.AbrirConexion();
                 unDS1 = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);



                 GridView2.DataSource = unDS1;
                 GridView2.DataBind();

                 Label3.Text = Session["Numero"].ToString().Trim();



             }
             finally
             {
                 unAcceso.CerrarConexion();
             }

         }

         protected void btnCerrar_Click(object sender, EventArgs e)
         {
             Panel1.Visible = false;
             gwGrilla.Visible = true;
         }

         protected void Button1_Click(object sender, EventArgs e)
         {
             Panel2.Visible = false;
             //gwGrilla.Visible = true;
         }

         protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
         {
             if (e.Row.RowType == DataControlRowType.DataRow)
             {

                 //if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Importe").ToString()))
                 //{
                 //    dKilos += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Importe"));
                 //}

                 //e.Row.Attributes.Add("onMouseOver", "this.style.background='#f2d9d9';this.style.cursor='pointer'");

                 //e.Row.Attributes.Add("onMouseOut", "this.style.background='#ffffff'");


                 //e.Row.Attributes["onClick"] = ClientScript.GetPostBackClientHyperlink(this.gwGrilla, "Select$" + e.Row.RowIndex);
                 //e.Row.ToolTip = "Haga Click para Seleccionar la línea.";

             }
             
             //if (e.Row.RowType == DataControlRowType.Footer)
             //{
             //    e.Row.BackColor = Color.Black;
             //    e.Row.ForeColor = Color.White;
             //    e.Row.Cells[3].Text = "Total Valores:";
             //    e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Center;
             //    e.Row.Cells[4].Text = dKilos.ToString("0.00");

             //}
         }

         protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
         {
             if (e.CommandName == "Anchos")
             {

                 int index = Convert.ToInt32(e.CommandArgument);

                 Session["Numero"] = this.GridView1.DataKeys[index].Values[0].ToString();



                 Panel2.Visible = true;

                 this.TraerAnchos("SP_PROD_RegistroInspeccionAnchosOPaquetes");
             }
         }

     

    }

       
}
