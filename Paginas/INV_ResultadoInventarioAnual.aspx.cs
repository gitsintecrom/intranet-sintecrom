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
    public partial class INV_ResultadoInventarioAnual : System.Web.UI.Page
    {
        decimal dKilos = 0;
        decimal dKilosAjuste = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.TraerStockInicial("SP_INV_InventarioAnualInicialTotal");
                this.TraerAltasExtraordinarias("SP_INV_TraerAltasExtraordinariaInventarioTotal");
                this.TraerAjustes("SP_InventarioAnualEtiquetasBTotal");
                this.TraerBajas("SP_INV_TraerBajasInventarioTotal");

                //this.TraerEtiquetas("SP_InventarioAnualResultadoTotal");

                Label5.Text = (Convert.ToInt32(btnInicial.Text) + Convert.ToInt32(btnAjuste.Text)  +
                                 Convert.ToInt32(btnExtra.Text) - Convert.ToInt32(Button1.Text)).ToString();
               
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

        private void TraerStockInicial(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;


            try
            {
               

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));

                if (unDS.Tables[0].Rows[0]["Kilos"].ToString() == "")
                   
                {
                    btnInicial.Text = "0";

                }

                else
                {
                    btnInicial.Text = unDS.Tables[0].Rows[0]["Kilos"].ToString();

                }

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerAltasExtraordinarias(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;


            try
            {


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));

                

                if (unDS.Tables[0].Rows[0]["Kilos"].ToString() == "")
                {
                    btnExtra.Text = "0";
                    
                }
                else
                {
                    btnExtra.Text = unDS.Tables[0].Rows[0]["Kilos"].ToString();

                }
               

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerAjustes(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;


            try
            {
               


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));
                foreach (DataTable table in unDS.Tables)
                {
                    foreach (DataRow dr in table.Rows)
                    {
                        dKilosAjuste += Convert.ToDecimal(dr["Kilos"]);

                    }
                    //dKilosAjuste += Convert.ToDecimal(unDS.Tables[0].Rows[0]["Kilos"]);
                }

                //    if (unDS.Tables[0].Rows[0]["Kilos"].ToString() == "")

                //{
                //    btnAjuste.Text = "0";


                //}
                //else
                //{
                //    btnAjuste.Text = unDS.Tables[0].Rows[0]["Kilos"].ToString();

                //}
                btnAjuste.Text = dKilosAjuste.ToString();


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerBajas(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;


            try
            {


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));

                if (unDS.Tables[0].Rows[0]["Kilos"].ToString() == "")

                {
                    Button1.Text = "0";
                    

                }
                else
                {
                    Button1.Text = unDS.Tables[0].Rows[0]["Kilos"].ToString();

                }

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
            this.TraerGrilla(gwGrilla, "dbo.SP_InventarioAnualResultado");
            btnExcel.Visible = true;
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

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= InventarioAnual.xls");
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
                e.Row.Cells[2].Text = "Total Kilos:";
                e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[3].Text = dKilos.ToString("0.00");
                lblTotal.Visible = true;
                lblInfo.Visible = true;
                lblTotal.Text = dKilos.ToString("0");

            }
        }

        protected void btnExtra_Click(object sender, EventArgs e)
        {
            this.TraerGrilla(gwGrilla, "dbo.SP_INV_TraerAltasExtraordinariaInventario");
            btnExcel.Visible = true;
        }

        protected void btnAjuste_Click(object sender, EventArgs e)
        {
            this.TraerGrilla(gwGrilla, "dbo.SP_InventarioAnualEtiquetasB");
            btnExcel.Visible = true;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            this.TraerGrilla(gwGrilla, "dbo.SP_INV_TraerBajasInventarioAnual");
            btnExcel.Visible = true;
        }

        //protected void Button2_Click(object sender, EventArgs e)
        //{
        //    this.TraerGrilla(gwGrilla, "dbo.SP_InventarioAnualResultadoDetalle");
        //    btnExcel.Visible = true;
        //}

        

    }

       
}
