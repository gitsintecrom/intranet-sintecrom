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
    public partial class VT_VentasPorVendedorDia : System.Web.UI.Page
    {

        decimal dKilos = 0;
        
        
        protected void Page_Load(object sender, EventArgs e)
        {

            //if (!IsPostBack)
            //{

                Session["Accede"] = "NO";
                string usuario = Clases.Varias.RemoveSpecialCharacters(Session["usr"].ToString());
                string sUsuario = Request.QueryString["Usuario"];
                 Session["Vendedor"] = Request.QueryString["Parametro"];


                if (usuario == sUsuario || usuario == "jcianfagna")
                {
                    Session["Accede"] = "OK";
                }

                else
                {
                    IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                    foreach (IdentityReference i in irc)
                    {
                        string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                        if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_DIRECCION")
                        {

                            Session["Accede"] = "OK";


                        }

                    }
                }
                if (Session["Accede"].ToString() == "NO")
                {
                    Response.Redirect("Restringida.aspx");

                }
                else
                {
                    this.TraerVentas("dbo.SP_TraerVentasPorDiaClienteXV");
                    this.TraerDetalleVentas("dbo.SP_TraerDetalleVentasPorVendedor");
                    Label1.Text = Session["Vendedor"].ToString();
                }


            //}
                     
           
                       
        }



      

       
        private void TraerVentas(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;

            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Vendedor", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["Vendedor"].ToString().Trim();

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);
               


                Chart4.DataSource = unDS;
                Chart4.Series["Series1"].XValueMember = "Fecha";
                Chart4.Series["Series1"].YValueMembers = "Dolares";
               
                Chart4.DataBind();

              




            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
     
        private void TraerVentasPorClientes(string nombreStored, string Fecha)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
           
            try
            {


                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@Vendedor", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["Vendedor"].ToString().Trim();
              
                unosParametros[1] = new SqlParameter("@Fecha", System.Data.SqlDbType.DateTime);
                unosParametros[1].Value = Fecha;

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);
               


                gwGrilla.DataSource = unDS;

                gwGrilla.DataBind();
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerDetalleVentas(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;

            try
            {


                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Vendedor", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["Vendedor"].ToString().Trim();

               
                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);



                gwGrilla.DataSource = unDS;               

                gwGrilla.DataBind();
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        protected void Chart4_Click(object sender, ImageMapEventArgs e)
        {
            dKilos = 0;
            string sFecha = e.PostBackValue.ToString();
            lblTitulo.Text = sFecha;
            this.TraerVentasPorClientes("dbo.SP_TraerDetalleVentasPorFechaXV", sFecha);
               

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

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= VentasPorCliente.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
        }

        protected void gwGrilla_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                
                if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Dolares").ToString()))
                {
                    dKilos += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Dolares"));
                }

                e.Row.Attributes.Add("onMouseOver", "this.style.background='#f2d9d9';this.style.cursor='pointer'");

                e.Row.Attributes.Add("onMouseOut", "this.style.background='#ffffff'");


                //e.Row.Attributes["onClick"] = ClientScript.GetPostBackClientHyperlink(this.gwGrilla, "Select$" + e.Row.RowIndex);
                //e.Row.ToolTip = "Haga Click para Seleccionar la línea.";

            }
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                //e.Row.BackColor = Color.DarkRed;
                //e.Row.ForeColor = Color.White;
                e.Row.Cells[3].Text = "Total Dolares:";
                e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[4].Text = dKilos.ToString("N0");

            }
        }
        

       
    }
}