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
    public partial class INV_InventarioPorDeposito : System.Web.UI.Page
    {
        decimal dKilos = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["Accede"] = "NO";


                IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                foreach (IdentityReference i in irc)
                {
                    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                    if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES") || group == ("DOMINIOW_ADMINISTRACION") || group == ("DOMINIOW_AUTORIZACION_COMERCIAL") || group == "DOMINIOW_SUPPLYCHAIN" || group == "DOMINIOW_CALIDAD" || group == "DOMINIOW_PRODUCCION")
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
                    CargarDepositos();
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
               
                unosParametros[0] = new SqlParameter("@Deposito", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = DropDownList2.SelectedValue;

                unosParametros[1] = new SqlParameter("@SL", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = txtBSerie.Text;

                unosParametros[2] = new SqlParameter("@Producto", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = txtProducto.Text;

                unosParametros[3] = new SqlParameter("@ProductoD", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = txtDesProducto.Text;  

               
                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);
                

                unGrid.DataSource = unDS;

                unGrid.DataBind();
                DataTable dt = unDS.Tables[0].Copy();


                Session["Tabla"] = dt;

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerGrillaDetalle(GridView unGrid, string nombreStored, string serie)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@SerieID", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = serie;

               


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

        public void CargarDepositos()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_INV_TraerComboDepositos"));

                DropDownList2.DataSource = unDS;
                DropDownList2.DataValueField = "Codigo";
                DropDownList2.DataTextField = "Nombre";
                DropDownList2.DataBind();
                DropDownList2.Items.Insert(0, new ListItem("Todos", "999"));

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
                                
                e.Row.Attributes.Add("onMouseOver", "this.style.background='#f2d9d9';this.style.cursor='pointer'");

                e.Row.Attributes.Add("onMouseOut", "this.style.background='#ffffff'");


                //e.Row.Attributes["onClick"] = ClientScript.GetPostBackClientHyperlink(this.gwGrilla, "Select$" + e.Row.RowIndex);
                //e.Row.ToolTip = "Haga Click para Seleccionar la línea.";

            }
           
        }

      

        protected void ButtonVer_Click(object sender, EventArgs e)
        {
            this.TraerGrilla(gwGrilla, "dbo.SP_InventarioTotal");
            btnExcel.Visible = true;
            Panel1.Visible = true;
            Panel2.Visible = false;
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

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= Inventario.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
        }

        protected void gwGrilla_RowDataBound1(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Kilos").ToString()))
                {
                    dKilos += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Kilos"));
                }               
               
                e.Row.Attributes.Add("onMouseOver", "this.style.background='#f2d9d9';this.style.cursor='pointer'");

                e.Row.Attributes.Add("onMouseOut", "this.style.background='#ffffff'");


                //e.Row.Attributes["onClick"] = ClientScript.GetPostBackClientHyperlink(this.gwGrilla, "Select$" + e.Row.RowIndex);
                //e.Row.ToolTip = "Haga Click para Seleccionar la línea.";

            }
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                //e.Row.BackColor = Color.DarkRed;
                e.Row.ForeColor = Color.White;
                e.Row.Cells[4].Text = "Total Kilos:";
                e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[5].Text = dKilos.ToString("0.00");
                lblTotal.Visible = true;
                lblInfo.Visible = true;
                lblTotal.Text = dKilos.ToString("0");

            }
        }

      
        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Panel2.Visible = false;
            Panel1.Visible = true;
        }

        protected void gwGrilla_RowCommand1(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Ver")
            {

                int index = Convert.ToInt32(e.CommandArgument);
                string sSerie = "";

                Panel1.Visible = false;
                Panel2.Visible = true;


                lblDetalle1.Text = (this.gwGrilla.DataKeys[index].Values[1]).ToString();
                lblDetalle2.Text = (this.gwGrilla.DataKeys[index].Values[2]).ToString();

                sSerie = (this.gwGrilla.DataKeys[index].Values[0]).ToString();

                this.TraerGrillaDetalle(gwDetalle, "dbo.SP_Inv_TraerDetalleCertificados", sSerie);



            }
        }

       
    }

       
}
