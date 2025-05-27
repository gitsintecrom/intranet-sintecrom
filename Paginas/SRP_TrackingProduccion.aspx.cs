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
    public partial class SRP_TrackingProduccion : System.Web.UI.Page
    {
        decimal dTotalCalidad = 0;
        decimal dTotalSobreOrden = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["Accede"] = "NO";
                Session["Accion"] = "";
                Session["Planta"] = "";


                IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                foreach (IdentityReference i in irc)
                {
                    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                    if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES") || group == ("DOMINIOW_VENTAS") || group == ("DOMINIOW_PRODUCCION") || group == ("DOMINIOW_CALIDAD") || group == ("DOMINIOW_SUPPLYCHAIN"))
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
                    
                }
              
            }
        
        }

      

        private void TraerGrilla(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("RegistracionNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;
          
            

            try
            {
                unosParametros = new SqlParameter[12];

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

                

                unosParametros[2] = new SqlParameter("@CodEstado", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = (DropDownList1.SelectedValue);

                unosParametros[3] = new SqlParameter("@NumeroBatch", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = txtBBatch.Text;

                unosParametros[4] = new SqlParameter("@SL", System.Data.SqlDbType.VarChar);
                unosParametros[4].Value = txtBSerie.Text;

                unosParametros[5] = new SqlParameter("@NumeroPedido", System.Data.SqlDbType.VarChar);
                unosParametros[5].Value = txtBPedido.Text;
               
                unosParametros[6] = new SqlParameter("@Abastecida", System.Data.SqlDbType.VarChar);
                unosParametros[6].Value = DropDownList2.SelectedValue;

                unosParametros[7] = new SqlParameter("@Maquina", System.Data.SqlDbType.VarChar);
                unosParametros[7].Value = txtBMaquina.Text;

                unosParametros[8] = new SqlParameter("@ConStock", System.Data.SqlDbType.VarChar);
                unosParametros[8].Value = DropDownList3.SelectedValue;

                unosParametros[9] = new SqlParameter("@Matching", System.Data.SqlDbType.VarChar);
                unosParametros[9].Value = txtBMatching.Text;

                unosParametros[10] = new SqlParameter("@Tipo", System.Data.SqlDbType.Int);
                unosParametros[10].Value = DropDownList4.SelectedValue;

                unosParametros[11] = new SqlParameter("@ACalidad", System.Data.SqlDbType.Int);
                unosParametros[11].Value = DropDownList5.SelectedValue;
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

        private void TraerGrillaItemPedido(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("RegistracionNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;

             

            try
            {
                unosParametros = new SqlParameter[2];


                unosParametros[0] = new SqlParameter("@Pedido", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["Pedido"].ToString().Trim();


                unosParametros[1] = new SqlParameter("@Operacion_ID", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = Session["Operacion_ID"].ToString().Trim();
               
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

        private void GeneroMaestro(string nombreSP)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("RegistracionNET");

            try
            {
                unAcceso.AbrirConexion();
                unAcceso.EjecutarSentencia_NonQuery(nombreSP);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }



        }

        protected void btnExcel_Click(object sender, ImageClickEventArgs e)
        {
            string nombre = "Tracking" + DateTime.Now.ToShortDateString();
            DataTable tabla = (DataTable)(Session["Tabla"]);

            Clases.Varias.ExportToSpreadsheet(tabla, nombre);
        }     


        protected void btnModificar_Click(object sender, EventArgs e)
        {
                //this.ActualizarDatos("dbo.SP_EfectuarTraslados");
                //gwGrilla.Visible = true;
                //this.TraerTraslados(gwGrilla, "dbo.SP_TraerTrasladosVigilancia");
                //Panel2.Visible = false;
        }


        protected void gwGrilla_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {

                int index = Convert.ToInt32(e.CommandArgument);


                Session["Operacion"] = this.gwGrilla.DataKeys[index].Values[0].ToString();
                Session["Clientes"] = this.gwGrilla.DataKeys[index].Values[1].ToString();
                Session["SerieE"] = this.gwGrilla.DataKeys[index].Values[2].ToString();
                Session["StockE"] = this.gwGrilla.DataKeys[index].Values[3].ToString();
                Session["Solicitud"] = this.gwGrilla.DataKeys[index].Values[4].ToString();
                Session["Pedido"] = this.gwGrilla.DataKeys[index].Values[5].ToString();
                Session["Operacion_ID"] = this.gwGrilla.DataKeys[index].Values[6].ToString();

            }
        }

        protected void gwGrilla_SelectedIndexChanged(object sender, EventArgs e)
        {      
            GridViewRow row = gwGrilla.SelectedRow;
            Panel2.Visible = true;
            this.TraerGrillaItemPedido(gvItemPedido, "dbo.SP_I_TraerSobreordenPorItemPedido");
            txtOperacion.Text = Session["Operacion"].ToString();
            txtClientes.Text = Session["Clientes"].ToString();
            txtSerieE.Text = Session["SerieE"].ToString();
            txtStockE.Text = Session["StockE"].ToString();   
           
            txtSolicitud.Text = Session["Solicitud"].ToString();
           
            gwGrilla.Visible = false;
            btnExcel.Visible = false;



           
        }

        protected void gwGrilla_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Kilos_Calidad").ToString()))
                {
                    dTotalCalidad += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Kilos_Calidad"));
                }

                if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Kilos_SobreOrden").ToString()))
                {
                    dTotalSobreOrden += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Kilos_SobreOrden"));
                }
                e.Row.Attributes.Add("onMouseOver", "this.style.background='#f2d9d9';this.style.cursor='pointer'");

                e.Row.Attributes.Add("onMouseOut", "this.style.background='#ffffff'");


                e.Row.Attributes["onClick"] = ClientScript.GetPostBackClientHyperlink(this.gwGrilla, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Haga Click para Seleccionar la línea.";

            }
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                e.Row.BackColor = Color.Black;
                e.Row.ForeColor = Color.White;
                e.Row.Cells[0].Text = "Totales:";
                e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[10].Text = dTotalCalidad.ToString("0.00");
                e.Row.Cells[10].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[11].Text = dTotalSobreOrden.ToString("0.00");
                e.Row.Cells[11].HorizontalAlign = HorizontalAlign.Center;

            }
        }

        protected void ButtonVer_Click(object sender, EventArgs e)
        {
            this.GeneroMaestro("dbo.SP_I_GeneraTrackingInventario");
            this.TraerGrilla(gwGrilla, "dbo.SP_I_TrackingInventario");

            //if (DropDownList1.SelectedValue == "Pendiente")
            //{
            //    this.TraerGrilla(gwGrilla, "dbo.SP_I_TrackingInventarioTEST");

            //}
            //else
            //{
            //    this.TraerGrilla(gwGrilla, "dbo.SP_I_TrackingInventario1");

            //}
            btnExcel.Visible = true;
        }

        protected void Button2_Click1(object sender, EventArgs e)
        {
            btnExcel.Visible = true;            
            gwGrilla.Visible = true;
            this.TraerGrilla(gwGrilla, "dbo.SP_I_TrackingInventario");
            Panel2.Visible = false;
        }


       

      
       

       

      
       
       


           

      
      

       
     

    }

       
}
