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




namespace SintecromNet.Paginas
{
    public partial class VT_Ventas : System.Web.UI.Page
    {
        decimal dTotalDolares = 0;
        decimal dTotalPesos = 0;
        decimal dTotalKilos = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["Accede"] = "NO";
                string usuario = Clases.Varias.RemoveSpecialCharacters(Session["usr"].ToString());

                if (usuario == "DOMINIOjcianfagna")
                {
                    Session["Accede"] = "OK";
                    this.TraerUsuarios("dbo.SP_Traer_UsuariosVentas");

                }

                else
                {
                    IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                    foreach (IdentityReference i in irc)
                    {
                        string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                        if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_DIRECCION" || group == "DOMINIOW_VENTAS")
                        {

                            Session["Accede"] = "OK";
                            this.TraerUsuarios("dbo.SP_Traer_UsuariosVentas");


                        }

                    }
                }
                if (Session["Accede"].ToString() == "NO")
                {
                    Response.Redirect("Restringida.aspx");

                }

            }
        
        }

        private void TraerUsuarios(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            string usuario = Clases.Varias.RemoveSpecialCharacters(Session["usr"].ToString());
            usuario = usuario.Replace("DOMINIO", "");


            try
            {


                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = usuario;
                
                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);
                Session["Nombre"] = unDS.Tables[0].Rows[0]["Nombre"].ToString();
                Session["CodVend"] = unDS.Tables[0].Rows[0]["CodVend"].ToString();
                Session["CodVend1"] = unDS.Tables[0].Rows[0]["CodVend1"].ToString();

                if (Session["CodVend"].ToString() == "0")
                    {
                        lblVendedor.Visible = true;
                        txtVendedor.Visible = true;
                        lblUsuario.Text = "Vendedores";
               
                    }
                else
                {
                    lblVendedor.Visible = false;
                    txtVendedor.Visible = false;
                    lblUsuario.Text = unDS.Tables[0].Rows[0]["Nombre"].ToString();

                }


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

      

        private void TraerGrilla(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;
          
            

            try
            {
                unosParametros = new SqlParameter[6];

                unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = TextBoxIni.Text;

                if (TextBoxFin.Text != "")
                {
                    DateTime dHasta = Convert.ToDateTime(TextBoxFin.Text, new System.Globalization.CultureInfo("es-ES"));
                    dHasta = dHasta.AddDays(1);
                    unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                    unosParametros[1].Value = dHasta;
                    
                }
                else
                {
                    unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                    unosParametros[1].Value = TextBoxFin.Text;
                }
                
                unosParametros[2] = new SqlParameter("@Cliente", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = txtCliente.Text.Trim();

                unosParametros[3] = new SqlParameter("@Codigo", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = Session["CodVend"].ToString();

                unosParametros[4] = new SqlParameter("@Codigo1", System.Data.SqlDbType.VarChar);
                unosParametros[4].Value = Session["CodVend1"].ToString();

                unosParametros[5] = new SqlParameter("@Vendedor", System.Data.SqlDbType.VarChar);
                unosParametros[5].Value = txtVendedor.Text.Trim();
                
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
      
        protected void btnExcel_Click(object sender, ImageClickEventArgs e)
        {
            string nombre = "Ventas" + DateTime.Now.ToShortDateString();
            DataTable tabla = (DataTable)(Session["Tabla"]);

            Clases.Varias.ExportToSpreadsheet(tabla, nombre);
        }     


        protected void gwGrilla_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {

                int index = Convert.ToInt32(e.CommandArgument);


               
                Session["Producto"] = this.gwGrilla.DataKeys[index].Values[0].ToString();
                Session["Domicilio"] = this.gwGrilla.DataKeys[index].Values[1].ToString();
                Session["Ciudad"] = this.gwGrilla.DataKeys[index].Values[2].ToString();

            }
        }

        protected void gwGrilla_SelectedIndexChanged(object sender, EventArgs e)
        {      
            GridViewRow row = gwGrilla.SelectedRow;
            Panel2.Visible = true;
            txtProducto.Text = Session["Producto"].ToString();
            txtDomicilio.Text = Clases.Varias.RemoveSpecialCharacters(Session["Domicilio"].ToString());
            txtCiudad.Text = Clases.Varias.RemoveSpecialCharacters(Session["Ciudad"].ToString());
           
            gwGrilla.Visible = false;
            btnExcel.Visible = false;



           
        }

        protected void gwGrilla_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Importe_Pesos").ToString()))
                {
                    dTotalPesos += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Importe_Pesos"));
                }

                if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "ImporteDolares").ToString()))
                {
                    dTotalDolares += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "ImporteDolares"));
                }

                if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Kilos").ToString()))
                {
                    dTotalKilos += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Kilos"));
                }


                
                e.Row.Attributes.Add("onMouseOver", "this.style.background='#f2d9d9';this.style.cursor='pointer'");
                e.Row.Attributes.Add("onMouseOut", "this.style.background='#ffffff'");

                e.Row.Attributes["onClick"] = ClientScript.GetPostBackClientHyperlink(this.gwGrilla, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Haga Click para Seleccionar la línea.";

            }
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                e.Row.BackColor = Color.DarkRed;
                e.Row.ForeColor = Color.White;
                e.Row.Cells[0].Text = "Totales:";
                e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[4].Text = dTotalKilos.ToString("0.00");
                e.Row.Cells[4].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[5].Text = dTotalPesos.ToString("0.00");
                e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[6].Text = dTotalDolares.ToString("0.00");
                e.Row.Cells[6].HorizontalAlign = HorizontalAlign.Center;

            }
           
        }

        protected void ButtonVer_Click(object sender, EventArgs e)
        {
            this.TraerGrilla(gwGrilla, "dbo.SP_Traer_FacturacionPorVendedor");
          
            btnExcel.Visible = true;
        }

        protected void Button2_Click1(object sender, EventArgs e)
        {
            btnExcel.Visible = true;            
            gwGrilla.Visible = true;
            this.TraerUsuarios("dbo.SP_Traer_UsuariosVentas");
            this.TraerGrilla(gwGrilla, "dbo.SP_Traer_FacturacionPorVendedor");
            Panel2.Visible = false;
        }


       

      
       

       

      
       
       


           

      
      

       
     

    }

       
}
