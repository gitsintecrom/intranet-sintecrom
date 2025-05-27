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
    public partial class VT_EstadoCarteraPedidos : System.Web.UI.Page
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

                    if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_VENTAS" || group == "DOMINIOW_GERENTES" || group == "DOMINIOW_ADMINISTRACION" ||
                        group == "DOMINIOW_SUPPLYCHAIN")
                    {

                        Session["Accede"] = "OK";



                    }

                }
                if (Session["Accede"].ToString() == "NO")
                {
                    Response.Redirect("Restringida.aspx");
                }
                //else
                //{
                //    this.ActualizarCumplimiento("xSp_I_Estado_cartera_pedidos");

                //}
              
            }

        
        }

        private void TraerCartera(GridView unGrid, GridView DosGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
           

            try
            {

              
                unosParametros = new SqlParameter[4];

                unosParametros[0] = new SqlParameter("@Cliente", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = txtCliente.Text;

                unosParametros[1] = new SqlParameter("@Vendedor", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = txtVendedor.Text;

                unosParametros[2] = new SqlParameter("@Numero", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = txtNumeroPedido.Text;

                unosParametros[3] = new SqlParameter("@Estado", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = DropDownList1.SelectedValue;

               
               

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);
                

                unGrid.DataSource = unDS;

                unGrid.DataBind();

                DosGrid.DataSource = unDS;

                DosGrid.DataBind();
                //DataTable dt = unDS.Tables[0].Copy();


                //Session["Tabla"] = dt;

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void ActualizarCumplimiento(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
            SqlParameter[] unosParametros = null;

           


            try
            {
                unosParametros = new SqlParameter[1];
                unosParametros[0] = new SqlParameter("@Dias", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt32(txtDias.Text);
                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreStored), unosParametros);

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
      

        protected void Button2_Click1(object sender, EventArgs e)
        {

        }

     
       


        protected void btnExcel_Click(object sender, ImageClickEventArgs e)
        {
            gwExcel.Visible = true;
           
            StringBuilder sb = new StringBuilder();
            StringWriter sw = new StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            Page page = new Page();
            HtmlForm form = new HtmlForm();
            gwExcel.EnableViewState = false;
            page.EnableEventValidation = false;
            page.DesignerInitialize();
            page.Controls.Add(form);
            form.Controls.Add(gwExcel);
            page.RenderControl(htw);

            Page.Response.Clear();
            Page.Response.Buffer = true;
            Page.Response.ContentType = "application/vnd.ms-excel";

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= CarteraPedidos.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();

            gwExcel.Visible = false;
        }

        protected void ButtonVer_Click(object sender, EventArgs e)
        {
            this.ActualizarCumplimiento("xSp_I_Estado_cartera_pedidos");

            gwNoCumplidos.Visible = true;
            this.TraerCartera(gwNoCumplidos, gwExcel, "dbo.SP_SeguimientoPedidos");


            if (gwNoCumplidos.Rows.Count > 0)
            {
                btnExcel.Visible = true;
            }
            else
            {
                btnExcel.Visible = false;
            }
        }



        protected void gwNoCumplidos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "VerEnFabrica")
            {

                int index = Convert.ToInt32(e.CommandArgument);

                Session["itemPedido"] = this.gwNoCumplidos.DataKeys[index].Values[0].ToString();

                decimal dFabricado = Convert.ToDecimal(this.gwNoCumplidos.DataKeys[index].Values[1].ToString());
                if (dFabricado > 0)
                {
                    Session["NumeroPedido"] = this.gwNoCumplidos.Rows[index].Cells[3].Text.ToString();
                    Session["Item"] = this.gwNoCumplidos.Rows[index].Cells[4].Text.ToString();
                    Session["Clon"] = this.gwNoCumplidos.Rows[index].Cells[5].Text.ToString();
                    Session["Programado"] = Math.Round(Convert.ToDecimal(this.gwNoCumplidos.DataKeys[index].Values[4].ToString()), 2);

                    Panel1.Visible = true;
                    gwNoCumplidos.Visible = false;
                    btnExcel.Visible = false;
                    this.TraerEnFabricacion("SP_TraerItemsDePedidoEnFabricacion");
                }
                else
                {
                    Response.Write("<script>window.alert('No Existe Material en Fabricación para el Item de Pedido Seleccionado');</script>");

                }


            }

            if (e.CommandName == "Fabricado")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                Session["itemPedido"] = this.gwNoCumplidos.DataKeys[index].Values[0].ToString();
                decimal dFabricado = Convert.ToDecimal(this.gwNoCumplidos.DataKeys[index].Values[2].ToString());
                decimal dEntregado = Convert.ToDecimal(this.gwNoCumplidos.DataKeys[index].Values[3].ToString());

                if (dFabricado > 0)
                {
                    Session["NumeroPedido"] = this.gwNoCumplidos.Rows[index].Cells[3].Text.ToString();
                    Session["Item"] = this.gwNoCumplidos.Rows[index].Cells[4].Text.ToString();
                    Session["Clon"] = this.gwNoCumplidos.Rows[index].Cells[5].Text.ToString();
                    Session["Programado"] = Math.Round(Convert.ToDecimal(this.gwNoCumplidos.DataKeys[index].Values[4].ToString()), 2);

                    Panel2.Visible = true;
                    gwNoCumplidos.Visible = false;
                    btnExcel.Visible = false;
                    this.TraerFabricado("SP_TrackingPedidoFabricado");
                }
                else
                {
                    Response.Write("<script>window.alert('No Existe Material Pendiente de Despacho Para el Item Seleccionado');</script>");

                }

            }

            if (e.CommandName == "Entregado")
            {

                int index = Convert.ToInt32(e.CommandArgument);

                Session["itemPedido"] = this.gwNoCumplidos.DataKeys[index].Values[0].ToString();

                decimal dFabricado = Convert.ToDecimal(this.gwNoCumplidos.DataKeys[index].Values[3].ToString());
                if (dFabricado > 0)
                {
                    Session["NumeroPedido"] = this.gwNoCumplidos.Rows[index].Cells[3].Text.ToString();
                    Session["Item"] = this.gwNoCumplidos.Rows[index].Cells[4].Text.ToString();
                    Session["Clon"] = this.gwNoCumplidos.Rows[index].Cells[5].Text.ToString();
                    Session["Programado"] = Math.Round(Convert.ToDecimal(this.gwNoCumplidos.DataKeys[index].Values[4].ToString()), 2); 

                    Panel3.Visible = true;
                    gwNoCumplidos.Visible = false;
                    btnExcel.Visible = false;
                    this.TraerEntregado("SP_TrackingPedidoDespachado");
                }
                else
                {
                    Response.Write("<script>window.alert('No Existe Material Despachado para el Item de Pedido Seleccionado');</script>");

                }
            }

            if (e.CommandName == "aProgramar")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                Session["itemPedido"] = this.gwNoCumplidos.DataKeys[index].Values[0].ToString();
                decimal dAprogramar = Math.Round(Convert.ToDecimal(this.gwNoCumplidos.DataKeys[index].Values[5].ToString()), 2);

                if (dAprogramar > 0)
                {
                    Session["NumeroPedido"] = this.gwNoCumplidos.Rows[index].Cells[3].Text.ToString();
                    Session["Item"] = this.gwNoCumplidos.Rows[index].Cells[4].Text.ToString();
                    Session["Clon"] = this.gwNoCumplidos.Rows[index].Cells[5].Text.ToString();
                    Session["aProgramar"] = dAprogramar;

                    Panel5.Visible = true;
                    gwNoCumplidos.Visible = false;
                    btnExcel.Visible = false;
                    this.TraerAprogramar("SP_TraerItemsPendientesdeProgramar");
                }
                else
                {
                    Response.Write("<script>window.alert('No Existe Material a Programar para el Item Seleccionado');</script>");

                }

            }

        }
        protected void gwNoCumplidos_RowDataBound(object sender, GridViewRowEventArgs e)
        {
             if (e.Row.RowType == DataControlRowType.DataRow)
             {
                 e.Row.Attributes.Add("onMouseOver", "this.style.background='#ebeaf2';this.style.cursor='pointer'");

                 e.Row.Attributes.Add("onMouseOut", "this.style.background='#ffffff'");


                 //e.Row.Attributes["onClick"] = ClientScript.GetPostBackClientHyperlink(this.gwNoCumplidos, "Select$" + e.Row.RowIndex);
                 e.Row.ToolTip = "Haga Click en los Respectivos Botones para Visualizar el Detalle.";
                
              }

        }

        protected void gwNoCumplidos_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void TraerAprogramar(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNET");
            SqlParameter[] unosParametros = null;

            DataSet unDS1 = null;

            Label31.Text = Session["NumeroPedido"].ToString();
            Label33.Text = Session["Item"].ToString();
            Label35.Text = Session["Clon"].ToString();
            Label37.Text = Session["aProgramar"].ToString();


            try
            {

                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("itemPedido_id", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["itemPedido"].ToString().Trim();


                unAcceso.AbrirConexion();
                unDS1 = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);


                gwGrilla3.DataSource = unDS1;
                gwGrilla3.DataBind();
                //CheckBoxList1.DataSource = unDS1;
                //CheckBoxList1.DataTextField = "Tarea";
                //CheckBoxList1.DataValueField = "Tarea";
                //CheckBoxList1.DataBind();



            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
      

        private void TraerEnFabricacion(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNET");
            SqlParameter[] unosParametros = null;

            DataSet unDS1 = null;

            lblNroPedido.Text = Session["NumeroPedido"].ToString();
            lblItem.Text = Session["Item"].ToString();
            lblClon.Text = Session["Clon"].ToString();
            lblProgramado.Text = Session["Programado"].ToString();


            try
            {

                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("itemPedido_id", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["itemPedido"].ToString().Trim();               


                unAcceso.AbrirConexion();
                unDS1 = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);
                


                gwGrilla.DataSource = unDS1;
                gwGrilla.DataBind();

               

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }


        private void TraerFabricado(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNET");
            SqlParameter[] unosParametros = null;

            DataSet unDS1 = null;

            
            Label6.Text = Session["NumeroPedido"].ToString();
            Label9.Text = Session["Item"].ToString();
            Label11.Text = Session["Clon"].ToString();
            Label13.Text = Session["Programado"].ToString();


            try
            {

                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("itemPedidoid", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["itemPedido"].ToString().Trim();


                unAcceso.AbrirConexion();
                unDS1 = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);



                gwGrilla1.DataSource = unDS1;
                gwGrilla1.DataBind();



            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerEntregado(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNET");
            SqlParameter[] unosParametros = null;

            DataSet unDS1 = null;


            Label15.Text = Session["NumeroPedido"].ToString();
            Label17.Text = Session["Item"].ToString();
            Label19.Text = Session["Clon"].ToString();
            Label21.Text = Session["Programado"].ToString();


            try
            {

                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("itemPedidoid", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["itemPedido"].ToString().Trim();


                unAcceso.AbrirConexion();
                unDS1 = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);



                gwGrilla2.DataSource = unDS1;
                gwGrilla2.DataBind();



            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        protected void btnCerrar_Click(object sender, EventArgs e)
        {
            Panel1.Visible = false;
            gwNoCumplidos.Visible = true;
            btnExcel.Visible = true;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Panel2.Visible = false;
            gwNoCumplidos.Visible = true;
            btnExcel.Visible = true;
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Panel3.Visible = false;
            gwNoCumplidos.Visible = true;
            btnExcel.Visible = true;
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            Panel5.Visible = false;
            gwNoCumplidos.Visible = true;
            btnExcel.Visible = true;
        }
     

    

    }

       
}
