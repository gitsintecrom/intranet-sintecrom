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
    public partial class VT_FichasTecnicas : System.Web.UI.Page
    {

        public string sVendedor { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["Parametro"] != null)
            {
                sVendedor = Request.QueryString["Parametro"];
            }
            if (!IsPostBack)
            {
                Session["Accede"] = "NO";


                IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                foreach (IdentityReference i in irc)
                {
                    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                    if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES") || group == ("DOMINIOW_VENDEDORES"))
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
                    CargarCombo();
                    CargarComboAleacion();
                    CargarComboEspesor();
                    CargarComboTemple();
                    CargarComboClientes();
                    CargarComboForma();
                }
               
            }
        
        }

      

        private void TraerGrilla(GridView unGrid, GridView dosGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;         
            

            try
            {
                unosParametros = new SqlParameter[7];
               
              
                unosParametros[0] = new SqlParameter("@Familia", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = ddFamilia.SelectedItem.Text.ToString(); 

                unosParametros[1] = new SqlParameter("@Espesor", System.Data.SqlDbType.VarChar);
                //unosParametros[1].Value = ddEspesor.SelectedItem.Text.ToString();
                unosParametros[1].Value = ddEspesor.SelectedValue;

                unosParametros[2] = new SqlParameter("@Aleacion", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = ddAleacion.SelectedItem.Text.ToString();

                unosParametros[3] = new SqlParameter("@Temple", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = ddTemple.SelectedItem.Text.ToString();

                unosParametros[4] = new SqlParameter("@Cliente", System.Data.SqlDbType.VarChar);
                unosParametros[4].Value = ddClientes.SelectedItem.Text.ToString();

                unosParametros[5] = new SqlParameter("@Vendedor", System.Data.SqlDbType.VarChar);
                unosParametros[5].Value = sVendedor;

                unosParametros[6] = new SqlParameter("@Forma", System.Data.SqlDbType.VarChar);
                unosParametros[6].Value = ddForma.SelectedValue;


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);
                

                unGrid.DataSource = unDS;

                unGrid.DataBind();

                dosGrid.DataSource = unDS;

                dosGrid.DataBind();
              

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void CargarComboClientes()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Vendedor", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = sVendedor;

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_CAL_TraerComboClientes"), unosParametros);

                ddClientes.DataSource = unDS;
                ddClientes.DataValueField = "Codigo";
                ddClientes.DataTextField = "Denominacion";
                ddClientes.DataBind();
                ddClientes.Items.Insert(0, new ListItem("Seleccione...", ""));

                DataTable dt = unDS.Tables[0].Copy();
                Session["Cliente"] = dt;


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

        private void CargarComboAleacion()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_CAL_TraerAleacion"));

                ddAleacion.DataSource = unDS;
                ddAleacion.DataValueField = "Codigo";
                ddAleacion.DataTextField = "Descripcion";
                ddAleacion.DataBind();
                ddAleacion.Items.Insert(0, new ListItem("Seleccione...", ""));

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void CargarComboTemple()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_CAL_TraerTemple"));

                ddTemple.DataSource = unDS;
                ddTemple.DataValueField = "Codigo";
                ddTemple.DataTextField = "Descripcion";
                ddTemple.DataBind();
                ddTemple.Items.Insert(0, new ListItem("Seleccione...", ""));

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void CargarComboForma()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_CAL_TraerForma"));

                ddForma.DataSource = unDS;
                ddForma.DataValueField = "Codigo";
                ddForma.DataTextField = "Descripcion";
                ddForma.DataBind();
                ddForma.Items.Insert(0, new ListItem("Seleccione...", ""));

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }


        private void CargarComboEspesor()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_CAL_TraerEspesor"));

                ddEspesor.DataSource = unDS;
                ddEspesor.DataValueField = "Codigo";
                ddEspesor.DataTextField = "Descripcion";
                ddEspesor.DataBind();
                ddEspesor.Items.Insert(0, new ListItem("Seleccione...", ""));

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
            
        }

     

        protected void gwGrilla_RowDataBound1(object sender, GridViewRowEventArgs e)
        {
            //if (e.Row.RowType == DataControlRowType.DataRow)
            //{

            //    if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Kilos").ToString()))
            //    {
            //        dKilos += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Kilos"));
            //    }               
               
            //    e.Row.Attributes.Add("onMouseOver", "this.style.background='#f2d9d9';this.style.cursor='pointer'");

            //    e.Row.Attributes.Add("onMouseOut", "this.style.background='#ffffff'");


            //    //e.Row.Attributes["onClick"] = ClientScript.GetPostBackClientHyperlink(this.gwGrilla, "Select$" + e.Row.RowIndex);
            //    //e.Row.ToolTip = "Haga Click para Seleccionar la línea.";

            //}
            //if (e.Row.RowType == DataControlRowType.Footer)
            //{
            //    //e.Row.BackColor = Color.DarkRed;
            //    e.Row.ForeColor = Color.White;
            //    e.Row.Cells[2].Text = "Stock:";
            //    e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Center;
            //    e.Row.Cells[3].Text = dKilos.ToString("0");
            //    lblTotal.Visible = true;
            //    lblInfo.Visible = true;
            //    lblTotal.Text = dKilos.ToString("0");

            //}
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            GridView1.Visible = true;
            StringBuilder sb = new StringBuilder();
            StringWriter sw = new StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            Page page = new Page();
            HtmlForm form = new HtmlForm();

            GridView1.EnableViewState = false;
            page.EnableEventValidation = false;
            page.DesignerInitialize();
            page.Controls.Add(form);
            form.Controls.Add(GridView1);
            page.RenderControl(htw);

            Page.Response.Clear();
            Page.Response.Buffer = true;
            Page.Response.ContentType = "application/vnd.ms-excel";

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= FichasTecnicas.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
            GridView1.Visible = false;

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            this.TraerGrilla(gwGrilla, GridView1, "dbo.SP_VT_TraerFichaTecnica");
            LinkButton2.Visible = true;
        }
        
    }

       
}
