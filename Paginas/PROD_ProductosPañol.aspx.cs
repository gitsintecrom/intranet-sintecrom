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
    public partial class PROD_ProductosPañol : System.Web.UI.Page
    {
        //public decimal costo { get; set; }
        //public string moneda { get; set; }
        //public decimal cotizacion { get; set; }
        //decimal dTotalD = 0;
        //decimal dTotalP = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["Accede"] = "NO";

                IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                foreach (IdentityReference i in irc)
                {
                    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                    if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES") || group == ("DOMINIOW_PANIOL"))
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
                    this.TraerGrilla(gwGrilla, "SP_PROD_TraerInsumosHeader");
                    //this.TraerGrillaHeader(gwHeader, "SP_PROD_TraerInsumosHeader");
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
                

              

                //for (int i = 0; i < unDS.Tables[0].Rows.Count; i++)
                //{
                   
                //    string codigo = unDS.Tables[0].Rows[i]["Codigo"].ToString();
                //    this.TraerCosto(codigo, "SP_COM_TraerPrecioInsumo");
                //    unDS.Tables[0].Rows[i]["Costo"] = costo;
                //    unDS.Tables[0].Rows[i]["Moneda"] = moneda;
                //    unDS.Tables[0].Rows[i]["Cotizacion"] = cotizacion;
                //}


                unGrid.DataSource = unDS;
                 
             




               

                unGrid.DataBind();
                //unGrid.Rows.add(0, txtNombre.Text, txtDireccion.Text, txtTelefono.Text);



            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

      


        //private void TraerCosto(string sCodigo, string nombreStored)
        //{
        //    Clases.AccesoDatos unAcceso1 = new Clases.AccesoDatos("SintecromNet");
        //    DataSet unDS1 = null;
        //    DataTable dt = null;
        //    SqlParameter[] unosParametros = null;

        //    try
        //    {


        //        unosParametros = new SqlParameter[1];

        //        unosParametros[0] = new SqlParameter("@codigo", System.Data.SqlDbType.VarChar);
        //        unosParametros[0].Value = sCodigo;




        //        unAcceso1.AbrirConexion();
        //        unDS1 = unAcceso1.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);

        //        if (unDS1.Tables[0].Rows.Count > 0)
        //        {
        //            costo = Convert.ToDecimal(unDS1.Tables[0].Rows[0]["precio"].ToString());
        //            moneda = (unDS1.Tables[0].Rows[0]["moneda"].ToString());
        //            cotizacion = Convert.ToDecimal(unDS1.Tables[0].Rows[0]["cotizacion"].ToString());


        //        }
        //        else
        //        {
        //            costo = 0;
        //            moneda = "";

        //        }



        //    }
        //    finally
        //    {
        //        unAcceso1.CerrarConexion();
        //    }
        //}










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

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= InventarioInsumos.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            this.TraerGrilla(gwGrilla, "SP_PROD_TraerInsumosLimite");
            lblMensaje.Text = "20 % Reposición";
            lblMensaje.BackColor = Color.Yellow;
            lblMensaje.ForeColor = Color.Black;

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            this.TraerGrilla(gwGrilla, "SP_PROD_TraerInsumosHeader");

            lblMensaje.Text = "Todos los Insumos Pañol";
            lblMensaje.BackColor = Color.LightBlue;
            lblMensaje.ForeColor = Color.Black;
        }

        protected void gwGrilla_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //if (e.Row.RowType == DataControlRowType.DataRow)
            //{
            //    if (e.Row.RowIndex == 0)
            //        e.Row.Style.Add("height", "10px");
            //}
        }

        protected void LinkButton4_Click(object sender, EventArgs e)
        {
            this.TraerGrilla(gwGrilla, "SP_PROD_TraerInsumosVencidos");
            lblMensaje.Text = "Insumos Vencidos";
            lblMensaje.BackColor = Color.Black;
            lblMensaje.ForeColor = Color.White;

        }

        protected void LinkButton5_Click(object sender, EventArgs e)
        {
            this.TraerGrilla(gwGrilla, "SP_PROD_TraerInsumosConsumos");
            lblMensaje.Text = "10 % Supra Consumo";
            lblMensaje.BackColor = Color.DarkBlue;
            lblMensaje.ForeColor = Color.White;


        }

        protected void LinkButton7_Click(object sender, EventArgs e)
        {
            this.TraerGrilla(gwGrilla, "SP_PROD_TraerInsumosConforme");

            lblMensaje.Text = "Insumos Conforme Stock";
            lblMensaje.BackColor = Color.DarkGreen;
            lblMensaje.ForeColor = Color.White;


        }

        protected void LinkButton6_Click(object sender, EventArgs e)
        {
            this.TraerGrilla(gwGrilla, "SP_PROD_TraerInsumosReposicion");

            lblMensaje.Text = "Insumos Para Reposición";
            lblMensaje.BackColor = Color.DarkRed;
            lblMensaje.ForeColor = Color.White;
        }

        protected void gwGrilla_RowDataBound1(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                e.Row.Attributes.Add("onMouseOver", "this.style.background='#d9e9f2';this.style.cursor='pointer'");

                e.Row.Attributes.Add("onMouseOut", "this.style.background='#ffffff'");
               

                //e.Row.Attributes["onClick"] = ClientScript.GetPostBackClientHyperlink(this.gwGrilla, "Select$" + e.Row.RowIndex);
                //e.Row.ToolTip = "Haga Click para Seleccionar la línea.";

            }
        }
    }

       
}
