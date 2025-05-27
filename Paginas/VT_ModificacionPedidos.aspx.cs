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
using System.Web.Security;


namespace SintecromNet.Paginas
{
    public partial class VT_ModificacionPedidos : System.Web.UI.Page
    {
        
        int RowPedido = 0;
        int RowProducto = 0;
        string LoteIngresada = "";

        protected void Page_Load(object sender, EventArgs e)
        {
           
            if (!IsPostBack)
            {
                Session["Accede"] = "NO";
                IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                foreach (IdentityReference i in irc)
                {
                    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                    if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_VENTAS" || group == "DOMINIOW_GERENTES" || group == "DOMINIOW_ADMINISTRACION")
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
                    this.MostrarPedidos("SP_VT_TraerPedidos");
                }             
            }
        }

        private void MostrarPedidos(string nombreStored)
        {
            Panel4.Visible = true;
            Panel1.Visible = false;
            Panel2.Visible = false;
            Panel3.Visible = false;
            Panel5.Visible = false;
            Panel7.Visible = false;
            Panel8.Visible = false;
            Panel9.Visible = false;

            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            
            try
            {
                gwPedidos.DataSource = null;
                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));
                gwPedidos.DataSource = unDS;
                gwPedidos.DataBind();

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }  

        protected void gwPedidos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            RowPedido = index;
            Session["NumeroPedido"] = this.gwPedidos.Rows[index].Cells[2].Text.ToString();
            Session["RazonSocial"] = this.gwPedidos.Rows[index].Cells[7].Text.ToString();
            Session["TipoCondicion"] = this.gwPedidos.Rows[index].Cells[3].Text.ToString();
            Session["TipoPedido"] = this.gwPedidos.Rows[index].Cells[4].Text.ToString();
            Session["TotalPedido"] = this.gwPedidos.Rows[index].Cells[6].Text.ToString();
            Session["CodCliente"] = this.gwPedidos.Rows[index].Cells[0].Text.ToString();
            Session["FechaPedido"] = this.gwPedidos.Rows[index].Cells[1].Text.ToString();
            Session["Reventa"] = this.gwPedidos.Rows[index].Cells[8].Text.ToString();
            Session["RespetaPrecioPedido"] = this.gwPedidos.Rows[index].Cells[9].Text.ToString();

            if (e.CommandName == "VerPedido")
            {
                Panel1.Visible = true;
                Panel8.Visible = false;
                Panel9.Visible = false;
                Panel4.Visible = false;
                this.TraerPedidoDetalle("SP_VT_TraerItemsDePedido");
            }

            if (e.CommandName == "AprobarPedido")
            {
                lblApruebaPedido.Text = "NUMERO DE PEDIDO: " + Session["NumeroPedido"].ToString();
                Panel4.Visible = false;
                Panel8.Visible = true;
                Panel9.Visible = false;
                Panel1.Visible = false;

            }

            if (e.CommandName == "EliminarPedido")
            {
                Label2.Text = "NUMERO DE PEDIDO: " + Session["NumeroPedido"].ToString();
                Panel4.Visible = false;
                Panel9.Visible = true;
                Panel8.Visible = false;
                Panel1.Visible = false;
            }
        }
        protected void gwPedidos_RowDataBound(object sender, GridViewRowEventArgs e)
        {
             if (e.Row.RowType == DataControlRowType.DataRow)
             {
                 //e.Row.Attributes.Add("onMouseOver", "this.style.background='#ebeaf2';this.style.cursor='pointer'");
                 //e.Row.Attributes.Add("onMouseOut", "this.style.background='#ffffff'");
                 //e.Row.ToolTip = "Haga Click en los Respectivos Botones para Visualizar el Detalle.";              
             }
        }

        protected void gwPedidos_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
      
        private void TraerPedidoDetalle(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNET");
            SqlParameter[] unosParametros = null;
            DataSet unDS1 = null;
            lblNroPedido.Text = Session["NumeroPedido"].ToString();
            lblCliente.Text = Session["RazonSocial"].ToString();
            try
            {
                unosParametros = new SqlParameter[1];
                unosParametros[0] = new SqlParameter("NumeroPedido", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Session["NumeroPedido"].ToString().Trim();               
                unAcceso.AbrirConexion();
                unDS1 = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);
                gwGrilla.DataSource = unDS1;
                gwGrilla.DataBind();
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
            DataTable dt;
            Session["dt"] = null;
            dt = filldata();
            Session["dt"] = unDS1;
            Session["CantReg"] = gwGrilla.Rows.Count;
        }


        protected void btnCerrar_Click(object sender, EventArgs e)
        {
            Panel1.Visible = false;
            Panel4.Visible = true;
            this.MostrarPedidos("SP_VT_TraerPedidos");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Panel4.Visible = true;
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Panel4.Visible = true;
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            Panel5.Visible = false;
            Panel4.Visible = true;
        }

        protected void gwGrilla_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {


        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Panel8.Visible = false;
            Panel9.Visible = false;
            lblPedidoResumen.Text = "Cliente: " + Session["RazonSocial"] +
                            "|  Ped: " + Session["NumeroPedido"].ToString() +
                            "|  " + Session["TipoPedido"].ToString() +
                            "|  Cond: " + Session["TipoCondicion"].ToString();
            lblPedidoTotal.Text = "TOTAL PEDIDO= " + Session["TotalPedido"].ToString();
            Panel1.Visible = false;
            Panel3.Visible = true;
            Panel5.Visible = true;
            if (Session["Reventa"].ToString()== "No")
            {   
                Panel2.Visible = true;
                Panel7.Visible = false;
                CargarComboProductos("Cliente");
                
            }
            else
            {
                Panel2.Visible = false;
                Panel7.Visible = true;
                Panel7.Height = 250;
            }
        }

        private void CargarComboProductos(string Cargo)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;
            if (Cargo != "TODO")
            {
                try
                {
                    unosParametros = new SqlParameter[1];
                    unosParametros[0] = new SqlParameter("@CODIGO_CLIENTE", System.Data.SqlDbType.VarChar);
                    unosParametros[0].Value = Session["CodCliente"].ToString();

                    unAcceso.AbrirConexion();
                    unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_VT_TraerProductosClientes"), unosParametros);

                    ddProductoItem.DataSource = unDS;
                    ddProductoItem.DataValueField = "CodProducto";
                    ddProductoItem.DataTextField = "DesProducto";
                    ddProductoItem.DataBind();
                    ddProductoItem.Items.Insert(0, new ListItem("Seleccione...", "0"));
                    ddProductoItem.SelectedIndex = 0;
                }
                finally
                {
                    unAcceso.CerrarConexion();
                }
            }
            else
            {
                try
                {
                    unAcceso.AbrirConexion();
                    unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_VT_TraerProductos"));

                    ddProductoItem.DataSource = unDS;
                    ddProductoItem.DataValueField = "CodProducto";
                    ddProductoItem.DataTextField = "DesProducto";
                    ddProductoItem.DataBind();
                    ddProductoItem.SelectedIndex = 0;
                }
                finally
                {
                    unAcceso.CerrarConexion();
                }
            }
        }

        protected void gwGrilla_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Muestro el producto en italica
                e.Row.Cells[1].Text = "<i>" + e.Row.Cells[1].Text + "</i>";
            }
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Panel1.Visible = true;
            Panel3.Visible = false;
            Panel2.Visible = false;
            Panel7.Visible = false;
            LimpioVariablesProducto();
        }

        private void LimpioVariablesProducto()
        {

        }

        protected void ddProductoItem_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (Session["TipoPedido"].ToString() == "Zstock")
            {
                txtPrecioLista.Text = "0";
                txtPrecioUnitario.Text = "0";
                return;
            }
            //buscar precio de lista
            //lista de precio
            txtPrecioUnitario.Text = "0";
            txtPrecioLista.Text = "0";
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlCommand cmd = new SqlCommand("dbo.SP_VT_TraerPrecios");
            DataSet unDS = null;
            try
            {
                unosParametros = new SqlParameter[1];
                unosParametros[0] = new SqlParameter("@Codigo", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = ddProductoItem.SelectedValue;
                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_VT_TraerPrecios"), unosParametros);

                if (unDS.Tables[0].Rows.Count > 0)
                {
                    string s = unDS.Tables[0].Rows[0].ItemArray[0].ToString();
                    for (int i = 0; i < s.Length; i++)
                    {
                        string c = s.Substring(i, 1);
                        if (c == "0" || c == "1" || c == "2" || c == "3" || c == "4" || c == "5" || c == "6" || c == "7" ||
                            c == "8" || c == "9" || c == "." || c == ",")
                        {
                            if (c == "." || c == ",")
                                c = ".";
                            txtPrecioLista.Text = txtPrecioLista.Text + c;
                            txtPrecioUnitario.Text = txtPrecioUnitario.Text + c;
                        }
                    }
                    txtPrecioLista.Text = Convert.ToString(Math.Round(Convert.ToDecimal(txtPrecioLista.Text.Replace(".", ",")), 3).ToString()).Replace(",", ".");
                    txtPrecioUnitario.Text = Convert.ToString(Math.Round(Convert.ToDecimal(txtPrecioUnitario.Text.Replace(".", ",")), 3).ToString()).Replace(",", ".");
                }
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        protected void btnAceptarItem_Click(object sender, EventArgs e)
        {
            //Panel6.Height = 150;
            //Panel6.Width = 300;
            decimal TotalItem = 0;
            if (Session["Reventa"].ToString() == "No")
            {
                if (ddProductoItem.SelectedItem.Text.ToString() == "Seleccione...")
                {
                    Response.Write("<script>window.alert('Debe seleccionar un Producto de la lista');</script>");
                    return;
                }
                if (txtFechaSolicitada.Text.Trim() != "" && Convert.ToDateTime(txtFechaSolicitada.Text).ToString("yyyy-MM-dd") != Convert.ToDateTime(txtFechaSolicitada.Text).ToString("1800-01-01"))
                {
                    if (Convert.ToDateTime(Session["FechaPedido"].ToString()) > Convert.ToDateTime(txtFechaSolicitada.Text))
                    {
                        Response.Write("<script>window.alert('La fecha solicitada no puede ser menor a la del Pedido');</script>");
                        return;
                    }
                }
                if (Session["TipoPedido"].ToString() != "Zstock")
                {
                    if (Session["RespetaPrecioPedido"].ToString() == "No")
                    {
                        if (txtPrecioLista.Text.Trim() == "" || txtPrecioLista.Text.Trim() == "0" ||
                            txtPrecioLista.Text.Trim() == "0,00" || txtPrecioLista.Text.Trim() == "0.00")
                        {
                            Response.Write("<script>window.alert('Debe tener Precio de Lista. Verifique.');</script>");
                            return;
                        }
                    }
                }
                //Panel6.Visible = true;
                if (txtPrecioLista.Text.Trim() == "")
                    txtPrecioLista.Text = "0";
                if (txtBonificacionPorcentaje.Text.Trim() == "")
                    txtBonificacionPorcentaje.Text = "0";
                if (txtIncremento.Text.Trim() == "")
                    txtIncremento.Text = "0";
                if (txtCantidad.Text.Trim() == "" || txtCantidad.Text.Trim() == "0")
                {
                    Response.Write("<script>window.confirm('Debe Ingresar La CANTIDAD a vender del producto');</script>");
                    return;
                }
                if ((txtPrecioUnitario.Text.Trim() == "" || txtPrecioUnitario.Text.Trim() == "0") && Session["TipoPedido"].ToString() != "Zstock")
                {
                    Response.Write("<script>window.confirm('Debe Ingresar el PRECIO UNITARIO del producto');</script>");
                    return;
                }
                bool Item10 = true;
                if (cbAutenticarProdCob.Checked.ToString() == "False")
                    Item10 = false;
                DateTime Item02 = Convert.ToDateTime("1800-01-01");
                if (txtFechaSolicitada.Text != "" && txtFechaSolicitada.Text != "&nbsp;")
                    Item02 = Convert.ToDateTime(txtFechaSolicitada.Text);
                TotalItem = Convert.ToDecimal(txtCantidad.Text.Replace(".", ",")) * Convert.ToDecimal(txtPrecioUnitario.Text.Replace(".", ","));
                if (txtIncremento.Text != "0")
                    TotalItem = Math.Round(TotalItem + Convert.ToDecimal(txtIncremento.Text.Replace(".", ",")) * TotalItem / 100, 3);
                if (txtBonificacionPorcentaje.Text != "0")
                    TotalItem = Math.Round(TotalItem - Convert.ToDecimal(txtBonificacionPorcentaje.Text.Replace(".", ",")) * TotalItem / 100, 3);

                this.InsertarItems("dbo.SP_VT_InsertarPedidosDetalle", ddProductoItem.SelectedValue, "",
                    Item02, Convert.ToDecimal(txtCantidad.Text.Replace(".", ",")), Convert.ToDecimal(txtPrecioUnitario.Text.Replace(".", ",")),
                    Convert.ToDecimal(txtPrecioLista.Text.Replace(".", ",")), Convert.ToDecimal(txtIncremento.Text.Replace(".", ",")), 
                    Convert.ToDecimal(txtBonificacionPorcentaje.Text.Replace(".", ",")), txtLoteAVender.Text,
                    Item10, TotalItem,"", "");

                //                  string nombreSP, string CodigoProducto, string DescProducto, DateTime FechaSolicitada, decimal Kilos, decimal PrecioUnitario,
                //                    decimal PrecioLista, decimal Incremento, decimal BonificacionPorcentaje, string LoteAVender,
                //                    bool Autenticar_ProductoCobertura, decimal TotalItem, string SerieID, string LoteID)

                ddProductoItem.SelectedIndex = 0;
                txtFechaSolicitada.Text = ""; 
                txtCantidad.Text = "";
                txtLoteAVender.Text = "";
                txtSerieID.Text = "";
                txtLoteID.Text = "";
                txtLoteAVenderCompleto.Text = "";
                txtPrecioUnitario.Text = "";
                txtPrecioLista.Text = "";
                txtIncremento.Text = "";
                txtBonificacionPorcentaje.Text = "";
                LoteIngresada = "";
                cbAutenticarProdCob.Checked = false;
                Panel2.Visible = false;
            }
            else //son los lotes a vender
            {
                if (txtLoteAVender.Text.ToString().Trim() == "" || txtProducto.Text.Trim() == "")
                {
                    Response.Write("<script>window.alert('Debe seleccionar una Serie-Lote');</script>");
                    return;
                }
                if (txtBonificacionPorcentaje0.Text.Trim() == "")
                    txtBonificacionPorcentaje0.Text = "0";
                if (txtIncremento0.Text.Trim() == "")
                    txtIncremento0.Text = "0";
                if (txtCantidad0.Text.Trim() == "" || txtCantidad0.Text.Trim() == "0" ||
                    txtCantidad0.Text.Trim() == "0,00" || txtCantidad0.Text.Trim() == "0.00")
                {
                    Response.Write("<script>window.alert('Debe Ingresar La CANTIDAD a vender del producto');</script>");
                    return;
                }
                if ((txtPrecioUnitario0.Text.Trim() == "" || txtPrecioUnitario0.Text.Trim() == "0") && Session["TipoPedido"].ToString() != "Zstock")
                {
                    Response.Write("<script>window.alert('Debe Ingresar el PRECIO UNITARIO del producto');</script>");
                    return;
                }
                bool Item10 = true;
                if (cbAutenticarProdCob.Checked.ToString() == "False")
                    Item10 = false;
                DateTime Item02 = Convert.ToDateTime("1800-01-01");
                if (txtFechaSolicitada0.Text != "" && txtFechaSolicitada0.Text != "&nbsp;")
                    Item02 = Convert.ToDateTime(txtFechaSolicitada0.Text);
                TotalItem = Convert.ToDecimal(txtCantidad0.Text.Replace(".", ",")) * Convert.ToDecimal(txtPrecioUnitario0.Text.Replace(".", ","));
                if (txtIncremento0.Text != "0")
                    TotalItem = Math.Round(TotalItem + Convert.ToDecimal(txtIncremento0.Text.Replace(".", ",")) * TotalItem / 100, 3);
                if (txtBonificacionPorcentaje0.Text != "0")
                    TotalItem = Math.Round(TotalItem - Convert.ToDecimal(txtBonificacionPorcentaje0.Text.Replace(".", ",")) * TotalItem / 100, 3);

                this.InsertarItems("dbo.SP_VT_InsertarPedidosDetalle", Session["CodProducto"].ToString(), "",
                    Item02, Convert.ToDecimal(txtCantidad0.Text.Replace(".", ",")), Convert.ToDecimal(txtPrecioUnitario0.Text.Replace(".", ",")),
                    0, Convert.ToDecimal(txtIncremento0.Text.Replace(".", ",")), Convert.ToDecimal(txtBonificacionPorcentaje0.Text.Replace(".", ",")), txtLoteAVenderCompleto.Text,//txtLoteAVender.Text,
                    Item10, TotalItem, txtSerieID.Text, txtLoteID.Text);

                txtProducto.Text = "";
                txtFechaSolicitada0.Text = "";  
                txtCantidad0.Text = "";
                txtLoteAVender.Text = "";
                txtSerieID.Text = "";
                txtLoteID.Text = "";
                txtLoteAVenderCompleto.Text = "";
                txtPrecioUnitario0.Text = "";
                txtIncremento0.Text = "";
                txtBonificacionPorcentaje0.Text = "";
                LblLoteAVender.Text = "";
                txtLoteAVender.Focus();
                Panel7.Visible = false;
            }
            Session["TotalPedido"] = Convert.ToDecimal(Session["TotalPedido"]) + TotalItem;
            Modificar_TotalPedido();
            Panel1.Visible = true;
            Panel8.Visible = false;
            Panel9.Visible = false;
            Panel4.Visible = false;
            Panel3.Visible = false;
            this.TraerPedidoDetalle("SP_VT_TraerItemsDePedido");
        }

        protected void Modificar_TotalPedido()
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlCommand cmd = new SqlCommand("SP_VT_EditarPedidos");
            try
            {
                unosParametros = new SqlParameter[2];
                unosParametros[0] = new SqlParameter("@NroPedido", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Session["NumeroPedido"].ToString().Trim();
                unosParametros[1] = new SqlParameter("@TotalPedido", System.Data.SqlDbType.Decimal);
                unosParametros[1].Value = Session["TotalPedido"].ToString().Trim();
                
                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(cmd, unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        public DataTable filldata()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("CodigoProducto", typeof(string));
            dt.Columns.Add("DescProducto", typeof(string));
            dt.Columns.Add("FechaSolicitada", typeof(string));
            dt.Columns.Add("Kilos", typeof(string));
            dt.Columns.Add("PrecioUnitario", typeof(string));
            dt.Columns.Add("PrecioLista", typeof(string));
            dt.Columns.Add("Incremento", typeof(string));
            dt.Columns.Add("PrecioIncremento", typeof(string));
            dt.Columns.Add("BonificacionPorcentaje", typeof(string));
            dt.Columns.Add("LoteAVender", typeof(string));
            dt.Columns.Add("Autenticar_ProductoCobertura", typeof(string));
            dt.Columns.Add("TotalItem", typeof(string));
            dt.Columns.Add("LoteAVender_Serie", typeof(string));
            dt.Columns.Add("LoteAVender_Lote", typeof(string));
            dt.Columns.Add("EliminarItem", typeof(string));
            dt.Columns.Add("LoteAVenderCompleto", typeof(string));
            return dt;
        }

        protected void txtLoteAVender_TextChanged(object sender, EventArgs e)
        {
            if (txtLoteAVender.Text.Trim() == "") // || txtLoteAVender.Text.Trim().Length < 9)
                return;
            if (txtLoteAVender.Text.Trim() == LoteIngresada)
                return;
            LoteIngresada = txtLoteAVender.Text.Trim();
            //BuscoProducto
            txtLoteID.Text = "";
            txtSerieID.Text = "";
            txtLoteAVenderCompleto.Text = "";
            Session["CodProducto"] = "";
            //int Pos = txtLoteAVender.Text.ToString().IndexOf("-", 0);
            //string Serie = txtLoteAVender.Text.Substring(0, Pos).Trim();
            //string Lote = txtLoteAVender.Text.Substring(Pos + 1, txtLoteAVender.Text.Length - Pos - 1).Trim();
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            try
            {
                unosParametros = new SqlParameter[1];
                unosParametros[0] = new SqlParameter("@SerieLote", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = txtLoteAVender.Text.Trim(); // Serie;
                //unosParametros[1] = new SqlParameter("@Lote", System.Data.SqlDbType.VarChar);
                //unosParametros[1].Value =Lote;
                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_VT_TraerProductosLotesAVender"), unosParametros);

                if (unDS.Tables[0].Rows.Count > 0)
                {
                    txtProducto.Text = unDS.Tables[0].Rows[0].ItemArray[0].ToString();
                    txtProducto.Enabled = false;
                    Session["CodProducto"] = unDS.Tables[0].Rows[0].ItemArray[0].ToString();
                    LblLoteAVender.Text = "Prod: " + unDS.Tables[0].Rows[0].ItemArray[1].ToString() + "<br>" +
                                          " Cant.: " + Math.Round(Convert.ToDecimal(unDS.Tables[0].Rows[0].ItemArray[2].ToString()), 2).ToString() + "<br>" +
                                          " Cant.No Lineal: " + Math.Round(Convert.ToDecimal(unDS.Tables[0].Rows[0].ItemArray[3].ToString()), 2).ToString();
                    Session["DescripLote"] = unDS.Tables[0].Rows[0].ItemArray[1].ToString();
                    txtCantidad0.Text = Math.Round(Convert.ToDecimal(unDS.Tables[0].Rows[0].ItemArray[2].ToString()), 2).ToString().Replace(",", ".");
                    txtCantidad0.Enabled = false;
                    txtSerieID.Text = unDS.Tables[0].Rows[0].ItemArray[4].ToString();
                    txtLoteID.Text = unDS.Tables[0].Rows[0].ItemArray[5].ToString();
                    txtLoteAVenderCompleto.Text = unDS.Tables[0].Rows[0].ItemArray[6].ToString();
                }
                else
                {
                    Response.Write("<script>window.alert('No existen productos con la Serie-Lote ingresada');</script>");
                    return;
                }
            }
            finally
            {
                unAcceso.CerrarConexion();
            }


        }

        protected void btnAprueba_Click(object sender, EventArgs e)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNET");
            SqlParameter[] unosParametros = null;
            DataSet unDS1 = null;
            try
            {
                unosParametros = new SqlParameter[1];
                unosParametros[0] = new SqlParameter("NumeroPedido", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Session["NumeroPedido"].ToString().Trim();
                unAcceso.AbrirConexion();
                unDS1 = unAcceso.ExecuteDataSet(new SqlCommand("SP_VT_AprobarPedido"), unosParametros);
                this.MostrarPedidos("SP_VT_TraerPedidos");

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
            gwPedidos.Visible = true;
            Panel8.Visible = false;
            Panel4.Visible = true;
        }

        protected void btnCancelaAprueba_Click(object sender, EventArgs e)
        {
            gwPedidos.Visible = true;
            Panel8.Visible = false;
            Panel4.Visible = true;
            //Panel1.Visible = true;
        }

        protected void btnElimina_Click(object sender, EventArgs e)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNET");
            SqlParameter[] unosParametros = null;
            DataSet unDS1 = null;
            try
            {
                unosParametros = new SqlParameter[1];
                unosParametros[0] = new SqlParameter("NumeroPedido", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Session["NumeroPedido"].ToString().Trim();
                unAcceso.AbrirConexion();
                unDS1 = unAcceso.ExecuteDataSet(new SqlCommand("SP_VT_EliminarPedido"), unosParametros);
                this.MostrarPedidos("SP_VT_TraerPedidos");
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
            //saco lìnea

            gwGrilla.Visible = true;
            Panel9.Visible = false;
        }

        protected void btnCancelaElimina_Click(object sender, EventArgs e)
        {

            gwGrilla.Visible = true;
            Panel9.Visible = false;
            Panel4.Visible = true;
            //Panel1.Visible = true;
        }

        private void InsertarItems(string nombreSP, string CodigoProducto, string DescProducto, DateTime FechaSolicitada, decimal Kilos, decimal PrecioUnitario,
                                    decimal PrecioLista, decimal Incremento, decimal BonificacionPorcentaje, string LoteAVender,
                                    bool Autenticar_ProductoCobertura, decimal TotalItem, string SerieID, string LoteID)
        {

            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlCommand cmd = new SqlCommand(nombreSP);
            //@NroPedido	int,
            //@TipoCondicion	int,
            //@ID_Producto	varchar(99),
            //@FechaSolicitado	datetime,
            //@Autenticar_ProductoCobertura bit,
            //@Cantidad	decimal,
            //@PrecioUnitario	decimal,
            //@PrecioLista	decimal,
            //@ListaPrecios	varchar(99),
            //@Incremento	decimal,
            //@BonificacionPorcentaje	decimal,
            //@LoteAVender	varchar(50)
            //@TotalItem decimal
            //

            try
            {
                unosParametros = new SqlParameter[15];

                unosParametros[0] = new SqlParameter("@NroPedido", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Session["NumeroPedido"].ToString().Trim();

                unosParametros[1] = new SqlParameter("@TipoCondicion", System.Data.SqlDbType.Int);
                unosParametros[1].Value = Session["TipoCondicion"].ToString().Trim();

                unosParametros[2] = new SqlParameter("@ID_Producto", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = CodigoProducto.ToUpper();

                unosParametros[3] = new SqlParameter("@FechaSolicitado", System.Data.SqlDbType.DateTime);
                unosParametros[3].Value = FechaSolicitada;

                unosParametros[4] = new SqlParameter("@Autenticar_ProductoCobertura", System.Data.SqlDbType.Bit);
                unosParametros[4].Value = Autenticar_ProductoCobertura;

                unosParametros[5] = new SqlParameter("@Cantidad", System.Data.SqlDbType.Decimal);
                unosParametros[5].Value = Convert.ToString(Kilos).Replace(".", ",");

                unosParametros[6] = new SqlParameter("@PrecioUnitario", SqlDbType.Decimal);
                unosParametros[6].Value = Convert.ToString(PrecioUnitario).Replace(".", ",");

                unosParametros[7] = new SqlParameter("@PrecioLista", System.Data.SqlDbType.Decimal);
                unosParametros[7].Value = Convert.ToString(PrecioLista).Replace(".", ",");

                unosParametros[8] = new SqlParameter("@ListaPrecios", System.Data.SqlDbType.VarChar);
                unosParametros[8].Value = "";

                unosParametros[9] = new SqlParameter("@Incremento", System.Data.SqlDbType.Decimal);
                unosParametros[9].Value = Incremento;

                unosParametros[10] = new SqlParameter("@BonificacionPorcentaje", System.Data.SqlDbType.Decimal);
                unosParametros[10].Value = BonificacionPorcentaje;

                unosParametros[11] = new SqlParameter("@LoteAVender", System.Data.SqlDbType.VarChar);
                unosParametros[11].Value = LoteAVender;

                unosParametros[12] = new SqlParameter("@TotalItem", System.Data.SqlDbType.Decimal);
                unosParametros[12].Value = Convert.ToString(TotalItem).Replace(".", ",");
                unosParametros[13] = new SqlParameter("@Serie_ID", System.Data.SqlDbType.VarChar);
                unosParametros[13].Value = SerieID.ToUpper();
                unosParametros[14] = new SqlParameter("@Lote_ID", System.Data.SqlDbType.VarChar);
                unosParametros[14].Value = LoteID.ToUpper();

                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(cmd, unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void EliminarItems(string nombreSP, string CodigoProducto,  decimal Kilos, decimal TotalItem,DateTime Fecha)
        {

            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlCommand cmd = new SqlCommand(nombreSP);
            try
            {
                unosParametros = new SqlParameter[5];
                unosParametros[0] = new SqlParameter("@NroPedido", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Session["NumeroPedido"].ToString().Trim();
                unosParametros[1] = new SqlParameter("@ID_Producto", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = CodigoProducto.ToUpper();
                unosParametros[2] = new SqlParameter("@Cantidad", System.Data.SqlDbType.Decimal);
                unosParametros[2].Value = Convert.ToString(Kilos).Replace(".", ",");
                unosParametros[3] = new SqlParameter("@TotalItem", System.Data.SqlDbType.Decimal);
                unosParametros[3].Value = Convert.ToString(TotalItem).Replace(".", ",");
                unosParametros[4] = new SqlParameter("@FechaSolicitado", System.Data.SqlDbType.DateTime);
                unosParametros[4].Value = Fecha;
                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(cmd, unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }


        protected void gwGrilla_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void gwGrilla_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            RowProducto = index;

            if (e.CommandName == "EliminarItem")
            {
                if (Convert.ToInt32(Session["CantReg"]) <= 1)
                {
                    Response.Write("<script>window.alert('No puede eliminar el item dado que el pedido tiene un solo Producto. Elimine el Pedido desde la pantalla anterior.');</script>");
                    return;
                }
                
                string id = gwGrilla.DataKeys[index].Value.ToString();

                //DataTable dt1 = Session["dt"] as DataTable;
                //DataRow[] rows = dt1.Select("CodigoProducto = '" + gwGrilla.Rows[index].Cells[0].Text + "' and Kilos = '" + gwGrilla.Rows[index].Cells[3].Text + 
                //                            "' and TotalItem = '" + gwGrilla.Rows[index].Cells[10].Text + "' and FechaSolicitada = '" + gwGrilla.Rows[index].Cells[2].Text + "'" );
                //if (rows.Count() <1)
                //{
                //    //Response.Write("<script>window.confirm('No puede eliminar el item dado que el pedido tiene un solo Producto. Elimine el Pedido desde la pantalla anterior.');</script>");
                //    Response.Write("<script>window.alert('No se puede eliminar el item solicitado.');</script>");
                //    return;
                //}

                EliminarItems("dbo.SP_VT_EliminarPedidosDetalle", gwGrilla.Rows[index].Cells[0].Text, Convert.ToDecimal(gwGrilla.Rows[index].Cells[3].Text),
                    Convert.ToDecimal(gwGrilla.Rows[index].Cells[10].Text), Convert.ToDateTime(gwGrilla.Rows[index].Cells[2].Text));

                txtProducto.Text = "";
                txtFechaSolicitada0.Text = "";  
                txtCantidad0.Text = "";
                txtLoteAVender.Text = "";
                txtSerieID.Text = "";
                txtLoteID.Text = "";
                txtLoteAVenderCompleto.Text = "";
                txtPrecioUnitario0.Text = "";
                txtIncremento0.Text = "";
                txtBonificacionPorcentaje0.Text = "";
                LblLoteAVender.Text = "";
                txtLoteAVender.Focus();
                Panel7.Visible = false;
                Panel2.Visible = false;

                Session["TotalPedido"] = Convert.ToDecimal(Session["TotalPedido"]) - Convert.ToDecimal(gwGrilla.Rows[index].Cells[10].Text.Replace(".", ","));
                Modificar_TotalPedido();
                Panel1.Visible = true;
                Panel8.Visible = false;
                Panel9.Visible = false;
                Panel4.Visible = false;
                Panel3.Visible = false;
                this.TraerPedidoDetalle("SP_VT_TraerItemsDePedido");

            }
        }

    }
}
