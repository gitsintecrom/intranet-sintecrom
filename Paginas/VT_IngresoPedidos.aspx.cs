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
using System.Net.Mail;
//using System.Security;
using System.Web.Security;

namespace SintecromNet.Paginas
{
    public partial class VT_IngresoPedidos : System.Web.UI.Page
    {
        int UltimoNumeroPedido =0;
        //decimal TotalPedido;
        bool OK = true;
        string LoteIngresada = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            //Response.Cache.SetCacheability(HttpCacheability.ServerAndNoCache);
            //Response.Cache.SetAllowResponseInBrowserHistory(false);
            //Response.Cache.SetNoStore();

            if (!IsPostBack)
            {
               
                btnAceptarPedido.Visible = false;
                Session["TotalPedido"] = "0";
                Session["Accede"] = "NO";
                Session["Cert"] = "";
                Session["DescripLote"] = "";
                Session["OcultaBonif"] = "0";
                Session["FacturaAntes"] = "0";
                Session["RespetaPrecio"] = "0";
                Session["LotesAVender"] = "0";
                Session["LoteIngresada"] = "";
                
                IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                foreach (IdentityReference i in irc)
                {
                    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());
                    //if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_VENTAS" || group == "DOMINIOW_VENDEDORES" || group == "DOMINIOW_GERENTES")
                    if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_AUTORIZACION_COMERCIAL")
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
                    CargarComboClientes();
                    CargarComboCondicion();
                    CargarComboMoneda();
                    CargarComboTipoPago();
                    CargarComboTransportista();
                    TextBoxIni.Text = DateTime.Today.ToString("yyyy-MM-dd"); // DateTime.Now.ToString();
                    Panel3.Visible = false;
                    Panel2.Visible = true;
                    Panel2.Height = 300;
                    Panel1.Visible = false;
                    Panel5.Visible = false;
                    Panel6.Visible = false;
                    Panel7.Visible = false;
                    Panel8.Visible = false;

                    ddTipo.Attributes.Add("onkeypress", "cambiaFoco('TextBoxIni')");
                    TextBoxIni.Attributes.Add("onkeypress", "cambiaFoco('ddClientesPedidos')");
                    ddClientesPedidos.Attributes.Add("onkeypress", "cambiaFoco('ddCondicion')");
                    ddCondicion.Attributes.Add("onkeypress", "cambiaFoco('ddMoneda')");
                    ddMoneda.Attributes.Add("onkeypress", "cambiaFoco('ddTipoPago')");
                    ddTipoPago.Attributes.Add("onkeypress", "cambiaFoco('txtOrdenCompra')");
                    txtOrdenCompra.Attributes.Add("onkeypress", "cambiaFoco('ddTransportista')");
                    ddTransportista.Attributes.Add("onkeypress", "cambiaFoco('ddDomicilioEntrega')");

                    ddFacturasAnticipadas.Visible = false;
                    Label16.Visible = false;
                    ddTipo.Focus();
                }           
            }
        }
      

        protected void btnAceptarPedido_Click(object sender, EventArgs e)
        {
            int i=0;
            if (this.gwGrilla.Rows.Count == 0)
            {
                Response.Write("<script>window.alert('Debe ingresar por lo menos un item al Pedido');</script>");
                return;
            }
            ArrayList ListItems = new ArrayList();
            if (!CBLotesAVender.Checked)
            {
                foreach (GridViewRow row in this.gwGrilla.Rows)
                {
                    ListItems.Add(
                        this.gwGrilla.Rows[row.RowIndex].Cells[1].Text.Substring(3, this.gwGrilla.Rows[row.RowIndex].Cells[1].Text.Length - 7) + "♫" +
                        this.gwGrilla.Rows[row.RowIndex].Cells[2].Text + "♫" +
                        this.gwGrilla.Rows[row.RowIndex].Cells[3].Text + "♫" +
                        this.gwGrilla.Rows[row.RowIndex].Cells[4].Text + "♫" +
                        this.gwGrilla.Rows[row.RowIndex].Cells[5].Text + "♫" +
                        this.gwGrilla.Rows[row.RowIndex].Cells[6].Text + "♫" +

                        this.gwGrilla.Rows[row.RowIndex].Cells[7].Text + "♫" +
                        this.gwGrilla.Rows[row.RowIndex].Cells[8].Text + "♫" +
                        this.gwGrilla.Rows[row.RowIndex].Cells[9].Text + "♫" +

                        this.gwGrilla.Rows[row.RowIndex].Cells[10].Text + "♫" +
                        this.gwGrilla.Rows[row.RowIndex].Cells[11].Text + "♫" +
                        this.gwGrilla.Rows[row.RowIndex].Cells[12].Text + "♫" +
                        this.gwGrilla.Rows[row.RowIndex].Cells[13].Text + "♫" +
                        this.gwGrilla.Rows[row.RowIndex].Cells[14].Text + "♫" +
                        this.gwGrilla.Rows[row.RowIndex].Cells[15].Text);
                    i++;
                }
            }
            else
            {
                foreach (GridViewRow row in this.gwGrilla.Rows)
                {
                    ListItems.Add(
                        this.gwGrilla.Rows[row.RowIndex].Cells[1].Text.Replace("<i>", "").Replace("</i>", "") + "♫" +
                        this.gwGrilla.Rows[row.RowIndex].Cells[2].Text + "♫" +
                        this.gwGrilla.Rows[row.RowIndex].Cells[3].Text + "♫" +
                        this.gwGrilla.Rows[row.RowIndex].Cells[4].Text + "♫" +
                        this.gwGrilla.Rows[row.RowIndex].Cells[5].Text + "♫" +
                        this.gwGrilla.Rows[row.RowIndex].Cells[6].Text + "♫" +

                        this.gwGrilla.Rows[row.RowIndex].Cells[7].Text + "♫" +
                        this.gwGrilla.Rows[row.RowIndex].Cells[8].Text + "♫" +
                        this.gwGrilla.Rows[row.RowIndex].Cells[9].Text + "♫" +

                        this.gwGrilla.Rows[row.RowIndex].Cells[10].Text + "♫" +
                        this.gwGrilla.Rows[row.RowIndex].Cells[11].Text + "♫" +
                        this.gwGrilla.Rows[row.RowIndex].Cells[12].Text + "♫" +
                        this.gwGrilla.Rows[row.RowIndex].Cells[13].Text + "♫" +
                        this.gwGrilla.Rows[row.RowIndex].Cells[14].Text + "♫" +
                        this.gwGrilla.Rows[row.RowIndex].Cells[15].Text);
                    i++;
                }
            }

            if (ListItems.Count == 0)
                Response.Write("<script>window.alert('Debe Ingresar por lo menos un item en el Pedido');</script>");
            else
            {
                this.InsertarDatos("dbo.SP_VT_InsertarPedidos");

                for (int f = 0; f < ListItems.Count; f++)
                {
                    bool Item10 = true;
                    string Item08 = "";
                    DateTime Item02 = Convert.ToDateTime("1800-01-01");
                    string[] ItemsPedidos = ListItems[f].ToString().Split('♫');
                    if (ItemsPedidos[10] == "No")
                        Item10 = false;
                    if (ItemsPedidos[2] != "" && ItemsPedidos[2] != "&nbsp;")
                        Item02 = Convert.ToDateTime(ItemsPedidos[2]);
                    if (ItemsPedidos[8] == "&nbsp;")
                        Item08 = "0";
                    else
                        Item08 = ItemsPedidos[9];
                    this.InsertarItems("dbo.SP_VT_InsertarPedidosDetalle", Convert.ToString(ItemsPedidos[0]), Convert.ToString(ItemsPedidos[1]),
                        Item02, Convert.ToDecimal(ItemsPedidos[3]), Convert.ToDecimal(ItemsPedidos[4]), 
                        Convert.ToDecimal(ItemsPedidos[5]), Convert.ToDecimal(ItemsPedidos[6]),
                        Convert.ToDecimal(ItemsPedidos[8]), Convert.ToString(ItemsPedidos[9]), Item10, Convert.ToDecimal(ItemsPedidos[11]),Convert.ToString(ItemsPedidos[12]),
                        Convert.ToString(ItemsPedidos[13]), Convert.ToString(ItemsPedidos[14]));
                }
     
                Panel8.Visible = true;
                Panel1.Visible = false;
                Panel3.Visible = false;
                Panel2.Visible = false;
                Panel6.Visible = false;
                Panel7.Visible = false;
                lblNumeroPedido.Text = "NUMERO DE PEDIDO: " + UltimoNumeroPedido.ToString();
            }
            


        }

        protected void btnCancelarPedido_Click(object sender, EventArgs e)
        {
            LimpiarCampos();

        }

        private void InsertarDatos(string nombreSP)
        {
            VerNumeroPedido(ddCondicion.SelectedValue);
            DateTime  Item02 = Convert.ToDateTime("1800-01-01");

            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlCommand cmd = new SqlCommand(nombreSP);
            try
            {
                unosParametros = new SqlParameter[22];
                unosParametros[0] = new SqlParameter("@NroPedido", System.Data.SqlDbType.Int);
                unosParametros[0].Value = UltimoNumeroPedido;

                unosParametros[1] = new SqlParameter("@TipoCondicion", System.Data.SqlDbType.Int);
                unosParametros[1].Value = ddCondicion.SelectedValue;

                unosParametros[2] = new SqlParameter("@ItemPedido", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = ddProductoItem.SelectedValue.ToUpper();

                unosParametros[3] = new SqlParameter("@TipoPedido", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = ddTipo.SelectedValue.ToUpper();

                unosParametros[4] = new SqlParameter("@Cliente_ID", System.Data.SqlDbType.VarChar);
                unosParametros[4].Value = ddClientesPedidos.SelectedValue.ToString().Substring(4, ddClientesPedidos.SelectedValue.ToString().Length - 4).ToUpper();

                unosParametros[5] = new SqlParameter("@ClienteDenominacion", System.Data.SqlDbType.VarChar);
                unosParametros[5].Value = ddClientesPedidos.SelectedItem.Text.ToString().ToUpper();

                unosParametros[6] = new SqlParameter("@UnidadNegocio", System.Data.SqlDbType.VarChar);
                unosParametros[6].Value = "S";

                unosParametros[7] = new SqlParameter("@OrdenCompraCliente", System.Data.SqlDbType.VarChar);
                unosParametros[7].Value = txtOrdenCompra.Text.Trim().ToUpper();

                unosParametros[8] = new SqlParameter("@OcultaBonificacion", System.Data.SqlDbType.VarChar);
                unosParametros[8].Value = Session["OcultaBonif"].ToString();

                unosParametros[9] = new SqlParameter("@TipoPago", System.Data.SqlDbType.VarChar);
                if (ddTipoPago.SelectedValue.ToString() == "0")
                    unosParametros[9].Value = "";
                else
                    unosParametros[9].Value = ddTipoPago.SelectedValue.ToUpper();
               

                unosParametros[10] = new SqlParameter("@Moneda", System.Data.SqlDbType.VarChar);
                unosParametros[10].Value = ddMoneda.SelectedValue.ToUpper();

                unosParametros[11] = new SqlParameter("@FacturaAntesdeRemitir", System.Data.SqlDbType.VarChar);
                unosParametros[11].Value = Session["FacturaAntes"].ToString();

                unosParametros[12] = new SqlParameter("@FacturaAnticipada", System.Data.SqlDbType.VarChar);
                if (ddFacturasAnticipadas.SelectedValue.ToString() == "0")
                    unosParametros[12].Value = "";
                else
                    unosParametros[12].Value = ddFacturasAnticipadas.SelectedValue.ToUpper();
                unosParametros[13] = new SqlParameter("@NotasProduccion", System.Data.SqlDbType.VarChar);
                unosParametros[13].Value = txtNotaProduccion.Text.Trim();

                unosParametros[14] = new SqlParameter("@DomicilioEntrega", System.Data.SqlDbType.VarChar);
                if (ddDomicilioEntrega.SelectedValue.ToString()== "0")
                    unosParametros[14].Value = "";
                else
                    unosParametros[14].Value = ddDomicilioEntrega.SelectedValue.ToString().ToUpper();
                unosParametros[15] = new SqlParameter("@Transportista", System.Data.SqlDbType.VarChar);
                if (ddTransportista.SelectedValue.ToString() == "0")
                    unosParametros[15].Value = "CA9690D2-DD76-4476-8C63-58BF140B5B8B";
                else
                    unosParametros[15].Value = ddTransportista.SelectedValue.ToString().ToUpper();
                unosParametros[16] = new SqlParameter("@RespetaPrecioPedido", System.Data.SqlDbType.VarChar);
                unosParametros[16].Value = Session["RespetaPrecio"].ToString();

                unosParametros[17] = new SqlParameter("@TotalPedido", System.Data.SqlDbType.Decimal);
                unosParametros[17].Value = Session["TotalPedido"].ToString().Replace(".",",") ;

                unosParametros[18] = new SqlParameter("@Fecha", System.Data.SqlDbType.DateTime);

                unosParametros[19] = new SqlParameter("@Reventa", System.Data.SqlDbType.VarChar);
                unosParametros[19].Value = Session["LotesAVender"].ToString();

                unosParametros[20] = new SqlParameter("@Estado", System.Data.SqlDbType.Int);
                unosParametros[20].Value = 0;

                unosParametros[21] = new SqlParameter("@CodCliente", System.Data.SqlDbType.VarChar);
                unosParametros[21].Value = ddClientesPedidos.SelectedValue.ToString().Substring(0, 4);

                if (TextBoxIni.Text != "")
                    Item02 = Convert.ToDateTime(TextBoxIni.Text);
                unosParametros[18].Value = Item02;

                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(cmd, unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();


            }
        }

        private void InsertarItems(string nombreSP, string CodigoProducto, string DescProducto, DateTime FechaSolicitada, decimal Kilos, decimal PrecioUnitario,
                                    decimal PrecioLista, decimal Incremento, decimal BonificacionPorcentaje, string LoteAVender, 
                                    bool Autenticar_ProductoCobertura, decimal TotalItem,string SerieID, string LoteID,string LoteAVenderComp) 
        {

            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlCommand cmd = new SqlCommand(nombreSP);
          

            try
            {
                unosParametros = new SqlParameter[15];

                unosParametros[0] = new SqlParameter("@NroPedido", System.Data.SqlDbType.Int);
                unosParametros[0].Value = UltimoNumeroPedido;

                unosParametros[1] = new SqlParameter("@TipoCondicion", System.Data.SqlDbType.Int);
                unosParametros[1].Value = ddCondicion.SelectedValue;

                unosParametros[2] = new SqlParameter("@ID_Producto", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = CodigoProducto.ToUpper();

                unosParametros[3] = new SqlParameter("@FechaSolicitado", System.Data.SqlDbType.DateTime);
                unosParametros[3].Value = FechaSolicitada;

                unosParametros[4] = new SqlParameter("@Autenticar_ProductoCobertura", System.Data.SqlDbType.Bit);
                unosParametros[4].Value = Autenticar_ProductoCobertura;

                unosParametros[5] = new SqlParameter("@Cantidad", System.Data.SqlDbType.Decimal);
                unosParametros[5].Value = Convert.ToString(Kilos).Replace(".", ",");

                unosParametros[6] = new SqlParameter("@PrecioUnitario", SqlDbType.Decimal);
                unosParametros[6].Value = Convert.ToString(PrecioUnitario).Replace(".",",");

                unosParametros[7] = new SqlParameter("@PrecioLista", System.Data.SqlDbType.Decimal);
                unosParametros[7].Value =Convert.ToString(PrecioLista).Replace(".",",");

                unosParametros[8] = new SqlParameter("@ListaPrecios", System.Data.SqlDbType.VarChar);
                unosParametros[8].Value = "";

                unosParametros[9] = new SqlParameter("@Incremento", System.Data.SqlDbType.Decimal);
                unosParametros[9].Value =  Convert.ToString(Incremento).Replace(".", ",");
 
                unosParametros[10] = new SqlParameter("@BonificacionPorcentaje", System.Data.SqlDbType.Decimal);
                unosParametros[10].Value = Convert.ToString(BonificacionPorcentaje).Replace(".", ","); 

                unosParametros[11] = new SqlParameter("@LoteAVender", System.Data.SqlDbType.VarChar);
                if (LoteAVender == "&nbsp;")
                    unosParametros[11].Value = "";
                else
                    unosParametros[11].Value = LoteAVenderComp;

                unosParametros[12] = new SqlParameter("@TotalItem", System.Data.SqlDbType.Decimal);
                unosParametros[12].Value =  Convert.ToString(TotalItem).Replace(".",",");
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

        private void LimpiarCampos()
        {
            ddTipo.SelectedValue = "Producto";
            TextBoxIni.Text = DateTime.Today.ToString("yyyy-MM-dd");
            ddClientesPedidos.SelectedValue = "0";
            ddCondicion.SelectedValue = "1";
            ddTipoPago.SelectedValue = "0";
            ddMoneda.SelectedIndex = 1;
            ddTransportista.SelectedValue = "CA9690D2-DD76-4476-8C63-58BF140B5B8B";
            ddDomicilioEntrega.SelectedIndex = 0;

            ddFacturasAnticipadas.Items.Clear();
            ddFacturasAnticipadas.Items.Insert(0, new ListItem("Seleccione...", "0"));
            ddFacturasAnticipadas.SelectedValue = "0";

            txtOrdenCompra.Text = "";
            txtLoteAVender.Text = "";
            txtProducto.Text = "";
            txtCantidad.Text = "";
            txtCantidad0.Text = "";
            txtPrecioUnitario.Text = "";
            txtPrecioUnitario0.Text = "";
            txtPrecioLista.Text = "";
            Session["DescripLote"] = "";
            Session["LoteIngresada"] = "";
                               
            txtNotaProduccion.Text = "";
            Panel1.Visible = false;
            Panel3.Visible = false;
            Panel2.Visible = true;
            Panel6.Visible = false;
            Panel7.Visible = false;
            Panel8.Visible = false;
            Session["TotalPedido"] = "0";
            Session["Accede"] = "NO";
            Session["Cert"] = "";
            Session["DescripLote"] = "";
            Session["OcultaBonif"] = "0";
            Session["FacturaAntes"] = "0";
            Session["RespetaPrecio"] = "0";
            Session["LotesAVender"] = "0";
            lblPedidoTotal.Text = "TOTAL PEDIDO= 0";

            //Borro Los datos de la grilla
            if (gwGrilla.Rows.Count > 0)
            {
                DataTable dt1 = Session["dt"] as DataTable;
                DataRow[] rows = dt1.Select();
                int cc = dt1.Rows.Count;
                for (int k = 0; k < cc; k++)
                {
                    dt1.Rows.Remove(rows[k]);
                }
                Session["dt"] = dt1;
                gwGrilla.DataSource = dt1;
                gwGrilla.DataBind();
                //gwGrilla.DataSource = null;
                //gwGrilla.DataBind();
            }

            cbAutenticarProdCob.Checked = false;
            CBOcultaBonif.Checked = false;
            CBFacturaAnticipada.Checked = false;
            CBRespetaPrecioPedido.Checked = false;
            CBInhabilitaFiltro.Checked = false;
            CBFacturaAntes.Checked = false;
            CBLotesAVender.Checked = false;
            btnAceptarPedido.Visible = false;
        }

        private void CargarComboClientes()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            try
            {
                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_VT_TraerComboClientes"));

                ddClientesPedidos.DataSource = unDS;
                ddClientesPedidos.DataValueField = "CODIGO_CLIENTE";
                ddClientesPedidos.DataTextField = "Denominacion";
                ddClientesPedidos.DataBind();
                ddClientesPedidos.Items.Insert(0, new ListItem("Seleccione...", "0"));
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void CargarComboCondicion()
        {
            ddCondicion.Items.Clear();
            ddCondicion.Items.Insert(0, new ListItem("1", "1"));
            ddCondicion.Items.Insert(1, new ListItem("45", "45"));
            ddCondicion.Items.Insert(2, new ListItem("90", "90"));
        }

        private void CargarComboTipoPago()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            try
            {
                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_VT_TraerComboTiposPago"));

                ddTipoPago.DataSource = unDS;
                ddTipoPago.DataValueField = "Codigo";
                ddTipoPago.DataTextField = "Descripcion";
                ddTipoPago.DataBind();
                ddTipoPago.Items.Insert(0, new ListItem("Seleccione...", "0"));
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
        private void CargarComboMoneda()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            try
            {
                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_VT_TraerComboMoneda"));

                ddMoneda.DataSource = unDS;
                ddMoneda.DataValueField = "Codigo";
                ddMoneda.DataTextField = "Descripcion";
                ddMoneda.DataBind();
                ddMoneda.Items.Insert(0, new ListItem("Seleccione...", "0"));
                ddMoneda.SelectedIndex = 1;
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void CargarComboFacturasAnticipadas()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;
            try
            {
                unosParametros = new SqlParameter[1];
                unosParametros[0] = new SqlParameter("@Cliente_ID", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = ddClientesPedidos.SelectedValue.ToString().Substring(4,ddClientesPedidos.SelectedValue.ToString().Length - 4) ;
                     
                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_VT_TraerComboAnticipadasCliente"), unosParametros);
                //Session["id_new"] = Convert.ToInt32(cmd.Parameters["@id_new"].Value);

                ddFacturasAnticipadas.DataSource = unDS;
                ddFacturasAnticipadas.DataValueField = "Factura_ID";
                ddFacturasAnticipadas.DataTextField = "Factura";
                ddFacturasAnticipadas.DataBind();
                ddFacturasAnticipadas.Items.Insert(0, new ListItem("Seleccione...", "0"));
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
        private void CargarComboDomiciliosEntrega()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;
            try
            {
                unosParametros = new SqlParameter[1];
                unosParametros[0] = new SqlParameter("@Cliente_ID", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = ddClientesPedidos.SelectedValue.ToString().Substring(4, ddClientesPedidos.SelectedValue.ToString().Length - 4);

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_VT_TraerDomicilioEntrega"), unosParametros);
                //Session["id_new"] = Convert.ToInt32(cmd.Parameters["@id_new"].Value);

                ddDomicilioEntrega.DataSource = unDS;
                ddDomicilioEntrega.DataValueField = "ID";
                ddDomicilioEntrega.DataTextField = "NombreDomicilio";
                ddDomicilioEntrega.DataBind();
                ddDomicilioEntrega.Items.Insert(0, new ListItem("Seleccione...", "0"));
                if (unDS.Tables[0].Rows.Count > 0) 
                    ddDomicilioEntrega.SelectedIndex = 1;
            }
            finally
            {
                unAcceso.CerrarConexion();
            }

        }

        private void CargarComboProductos(string Cargo)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;
            if (Cargo == "Cliente")
            {
                try
                {
                    unosParametros = new SqlParameter[1];
                    unosParametros[0] = new SqlParameter("@CODIGO_CLIENTE", System.Data.SqlDbType.VarChar);
                    unosParametros[0].Value = ddClientesPedidos.SelectedValue.ToString().Substring(0, 4);

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

        private void CargarComboTransportista()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            try
            {
                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_VT_TraerTransportes"));

                ddTransportista.DataSource = unDS;
                ddTransportista.DataValueField = "ID";
                ddTransportista.DataTextField = "Nombre";
                ddTransportista.DataBind();
                ddTransportista.Items.Insert(0, new ListItem("NA", "CA9690D2-DD76-4476-8C63-58BF140B5B8B"));
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
                unosParametros = new SqlParameter[2];
                unosParametros[0] = new SqlParameter("@NroRemito", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = "";
                unosParametros[1] = new SqlParameter("@Cliente", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = ddClientesPedidos.SelectedValue;       
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

        private bool EnviarEmail()
        {

            MailMessage msg = new MailMessage();
            msg.To.Add("gbroide@sintecrom.com.ar, megonzalez@sintecrom.com.ar, ninsua@sintecrom.com.ar");
            msg.From = new MailAddress("mail.sistemas.sintecrom@gmail.com", "Reclamos Clientes", System.Text.Encoding.UTF8);
            msg.Subject = "Autorización Reclamo Clientes";
            msg.SubjectEncoding = System.Text.Encoding.UTF8;
            msg.Body = "Existe un Nuevo Reclamo Para Autorizar del Cliente: " + ddClientesPedidos.SelectedValue;
            msg.BodyEncoding = System.Text.Encoding.UTF8;
            msg.IsBodyHtml = false; //Si vas a enviar un correo con contenido html entonces cambia el valor a true
                                    //Aquí es donde se hace lo especial

            SmtpClient client = new SmtpClient();

            //client.Credentials = new System.Net.NetworkCredential("mail.sistemas.sintecrom@gmail.com", "Sinte1234");

            client.Port = 587;

            client.Host = "smtp.gmail.com";//Este es el smtp valido para Gmail

            client.EnableSsl = true; //Esto es para que vaya a través de SSL que es obligatorio con GMail

            client.UseDefaultCredentials = false;
            //client.Credentials = new System.Net.NetworkCredential("mail.sistemas.sintecrom@gmail.com", "Sinte.2023*");
            client.Credentials = new System.Net.NetworkCredential("mail.sistemas.sintecrom@gmail.com", "elvyffedyeximpwp");
            client.DeliveryMethod = SmtpDeliveryMethod.Network;

            try
            {
                client.Send(msg);

                return true;
            }

            catch (Exception)
            {
                return false;
            }

        }

        protected void btnVerCabecera_Click(object sender, EventArgs e)
        {
            Panel1.Visible = false;
            Panel2.Visible = true;
            Panel3.Visible = false;
            Panel5.Visible = false;
            Panel6.Visible = false;
            Panel7.Visible = false;
            Panel8.Visible = false;
        }

        protected void gwGrilla_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Muestro el producto en italica
                e.Row.Cells[1].Text = "<i>" + e.Row.Cells[1].Text + "</i>";
            }
        }

        //protected void btn_eliminar_Click(object sender, GridViewDeleteEventArgs e)
        //{
        //    int index = Convert.ToInt32(e.RowIndex);
        //    string id = gwGrilla.DataKeys[index].Value.ToString();

        //    DataTable dt1 = Session["dt"] as DataTable;

        //    DataRow[] rows = dt1.Select(string.Format("nombrecampo = {0}", id));
        //    if (rows.Count() > 0)
        //    {
        //        dt1.Rows.Remove(rows[0]);
        //    }

        //    Session["dt"] = dt1;

        //    gwGrilla.DataSource = dt1;
        //    gwGrilla.DataBind();
        //} 

        protected void btnIngresarItems_Click(object sender, EventArgs e)
        {
            if (ddClientesPedidos.SelectedItem.Text.ToString() == "Seleccione..." || ddTipo.SelectedValue == "Producto")
                return;
            //if (txtOrdenCompra.Text.Trim() == "" || txtOrdenCompra.Text.Trim() == "0")
            //{
            //    Response.Write("<script>window.alert('Debe Ingresar ORDEN DE COMPRA');</script>");
            //    return;
            //}
            if (!CBLotesAVender.Checked && ddTipo.SelectedValue != "F")
            {
                Panel1.Visible = true;
                //Panel1.Height = 200;
                Panel2.Visible = false;
                Panel3.Visible = true;
                Panel5.Visible = true;
                Panel6.Visible = true;
                //Panel6.Height = 10;
                Panel7.Visible = false;
                Panel8.Visible = false;
                lblPedidoResumen.Text = "Cliente: " + ddClientesPedidos.SelectedItem.Text.ToString() +
                                            "|  " + ddTipo.SelectedItem.Text.ToString() + "     |  " + TextBoxIni.Text +
                                            "|  Cond: " + ddCondicion.SelectedItem.Text.ToString();
                if (txtOrdenCompra.Text.Trim() != "")
                    lblPedidoResumen.Text = lblPedidoResumen.Text + "|  OC: " + txtOrdenCompra.Text;
                lblPedidoTotal.Text = "TOTAL PEDIDO= " + Session["TotalPedido"].ToString() + "   " + ddMoneda.SelectedItem.Text.ToString();
                txtFechaSolicitada.Text = ""; // Convert.ToDateTime(TextBoxIni.Text).ToString("yyyy-MM-dd");

                if (CBInhabilitaFiltro.Checked)
                {
                    CargarComboProductos("Todos");
                }
                else
                {
                    CargarComboProductos("Cliente");
                }
            }
            else
            {
                Panel1.Visible = false;
                Panel2.Visible = false;
                Panel3.Visible = true;
                Panel5.Visible = true;
                Panel6.Visible = true;
                //Panel6.Height = 10;
                Panel7.Visible = true;
                //Panel7.Height = 250;
                Panel8.Visible = false;
                lblPedidoResumen.Text = "Cliente: " + ddClientesPedidos.SelectedItem.Text.ToString() +
                                            "|  " + ddTipo.SelectedItem.Text.ToString() + "     |  " + TextBoxIni.Text +
                                            "|  Cond: " + ddCondicion.SelectedItem.Text.ToString();
                if (txtOrdenCompra.Text.Trim() != "")
                    lblPedidoResumen.Text = lblPedidoResumen.Text + "|  OC: " + txtOrdenCompra.Text;
                lblPedidoTotal.Text = "TOTAL PEDIDO= " + Session["TotalPedido"].ToString() + "   " + ddMoneda.SelectedItem.Text.ToString();
                txtFechaSolicitada0.Text = ""; // Convert.ToDateTime(TextBoxIni.Text).ToString("yyyy-MM-dd");


            }
            if (CBOcultaBonif.Checked)
                Session["OcultaBonif"] = "1";
            else
                Session["OcultaBonif"] = "0";
            if(CBFacturaAntes.Checked)
                Session["FacturaAntes"] = "1";
            else
                Session["FacturaAntes"] = "0";
            if (CBRespetaPrecioPedido.Checked)
                Session["RespetaPrecio"] = "1";
            else
                Session["RespetaPrecio"] = "0";
            if (CBLotesAVender.Checked)
                Session["LotesAVender"] = "1";
            else
                Session["LotesAVender"] = "0";
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
            dt.Columns.Add("LoteAVenderCompleto", typeof(string));
            return dt;
        }

        protected void btnAceptarItem_Click(object sender, EventArgs e)
        {
            Panel6.Height = 150;
            Panel6.Width = 300;
            if (Session["LotesAVender"] == "0" && ddTipo.SelectedValue != "F")
            {
                if (ddProductoItem.SelectedItem.Text.ToString() == "Seleccione...")
                {
                    Response.Write("<script>window.alert('Debe seleccionar un Producto de la lista');</script>");
                    return;
                }
                if (txtFechaSolicitada.Text.Trim() != "" && Convert.ToDateTime(txtFechaSolicitada.Text).ToString("yyyy-MM-dd") != Convert.ToDateTime(txtFechaSolicitada.Text).ToString("1800-01-01"))
                {
                    if (Convert.ToDateTime(TextBoxIni.Text) > Convert.ToDateTime(txtFechaSolicitada.Text))
                    {
                        Response.Write("<script>window.alert('La fecha solicitada no puede ser menor a la del Pedido');</script>");
                        return;
                    }
                }
                if (ddTipo.SelectedValue != "Z")
                {
                    if (!CBRespetaPrecioPedido.Checked)
                    {
                        if (txtPrecioLista.Text.Trim() == "" || txtPrecioLista.Text.Trim() == "0" ||
                            txtPrecioLista.Text.Trim() == "0,00" || txtPrecioLista.Text.Trim() == "0.00")
                        {
                            Response.Write("<script>window.alert('Debe tener Precio de Lista. Verifique.');</script>");
                            return;
                        }
                    }
                }
                Panel6.Visible = true;
                if (txtPrecioLista.Text.Trim() == "")
                    txtPrecioLista.Text = "0";
                if (txtBonificacionPorcentaje.Text.Trim() == "")
                    txtBonificacionPorcentaje.Text = "0";
                if (txtIncremento.Text.Trim() == "")
                    txtIncremento.Text = "0";
                if (txtCantidad.Text.Trim() == "" || txtCantidad.Text.Trim() == "0")
                {
                    Response.Write("<script>window.alert('Debe Ingresar La CANTIDAD a vender del producto');</script>");
                    return;
                }
                if ((txtPrecioUnitario.Text.Trim() == "" || txtPrecioUnitario.Text.Trim() == "0") && ddTipo.SelectedValue != "Z")
                {
                    Response.Write("<script>window.alert('Debe Ingresar el PRECIO UNITARIO del producto');</script>");
                    return;
                }

                DataTable dt;
                if (Session["dt"] == null)
                {
                    dt = filldata();
                }
                else
                {
                    dt = (Session["dt"]) as DataTable;
                }
                DataRow Row1;
                Row1 = dt.NewRow();
                Row1["CodigoProducto"] = this.ddProductoItem.SelectedValue;
                int Pos = ddProductoItem.SelectedItem.Text.ToString().IndexOf("||", 0);
                string Desc = ddProductoItem.SelectedItem.Text.ToString().Substring(Pos + 2, ddProductoItem.SelectedItem.Text.ToString().Length - Pos - 2);
                Row1["DescProducto"] = Desc;
                Row1["FechaSolicitada"] = this.txtFechaSolicitada.Text;
                Row1["Kilos"] = this.txtCantidad.Text.Replace(".", ",");
                Row1["PrecioUnitario"] = this.txtPrecioUnitario.Text.Replace(".", ",");
                Row1["PrecioLista"] = this.txtPrecioLista.Text.Replace(".", ",");
                Row1["Incremento"] = this.txtIncremento.Text.Replace(".", ",");
                Row1["BonificacionPorcentaje"] = this.txtBonificacionPorcentaje.Text.Replace(".", ",");
                Row1["LoteAVender"] = "";
                if (this.cbAutenticarProdCob.Checked.ToString() == "False")
                    Row1["Autenticar_ProductoCobertura"] = "No";
                else
                    Row1["Autenticar_ProductoCobertura"] = "Si";
                decimal TotalItem = Convert.ToDecimal(txtCantidad.Text.Replace(".", ",")) * Convert.ToDecimal(txtPrecioUnitario.Text.Replace(".", ","));
                decimal TotalIncre = 0;
                if (txtIncremento.Text != "0")
                {
                    TotalItem = Math.Round(TotalItem + Convert.ToDecimal(txtIncremento.Text.Replace(".", ",")) * TotalItem / 100, 3);
                    decimal Prec = Convert.ToDecimal(txtPrecioUnitario.Text.Replace(".", ","));
                    TotalIncre = Math.Round(Prec + Convert.ToDecimal(txtIncremento.Text.Replace(".", ",")) * Prec / 100, 3);
                }
                Row1["PrecioIncremento"] = TotalIncre;
                if (txtBonificacionPorcentaje.Text != "0")
                    TotalItem = Math.Round(TotalItem - Convert.ToDecimal(txtBonificacionPorcentaje.Text.Replace(".", ",")) * TotalItem / 100, 3);

                Row1["TotalItem"] = TotalItem;
                Row1["LoteAVender_Serie"] = "";
                Row1["LoteAVender_Lote"] = "";
                Session["TotalPedido"] = Convert.ToDecimal(Session["TotalPedido"]) + TotalItem;
                lblPedidoTotal.Text = "TOTAL PEDIDO= " + Convert.ToString(Session["TotalPedido"]).Replace(",", ".") + "   " + ddMoneda.SelectedItem.Text.ToString();
                dt.Rows.Add(Row1);
                gwGrilla.DataSource = dt;
                gwGrilla.DataBind();
                Session["dt"] = dt;
                btnAceptarPedido.Visible = true;

                ddProductoItem.SelectedIndex = 0;
                txtFechaSolicitada.Text = ""; //Convert.ToDateTime(TextBoxIni.Text).ToString("yyyy-MM-dd");
                txtCantidad.Text = "";
                txtLoteAVender.Text = "";
                txtSerieID.Text = "";
                txtLoteID.Text = "";
                txtLoteAVenderCompleto.Text = "";
                txtPrecioUnitario.Text = "";
                txtPrecioLista.Text = "";
                txtIncremento.Text = "";
                Session["LoteIngresada"] = "";
                txtBonificacionPorcentaje.Text = "";
                cbAutenticarProdCob.Checked = false;
                ddProductoItem.Focus();
            }
            else //son los lotes a vender o fraccionamiento
            {
                if (txtLoteAVender.Text.ToString().Trim() == "" || txtProducto.Text.Trim() == "")
                {
                    Response.Write("<script>window.alert('Debe seleccionar una Serie-Lote');</script>");
                    return;
                }
                //verifico que no haya ingresado la misma serie lote
                foreach (GridViewRow row in this.gwGrilla.Rows)
                {
                    if (gwGrilla.Rows[row.RowIndex].Cells[10].Text == txtLoteAVender.Text.ToString().Trim())
                    {
                        Response.Write("<script>window.alert('Esta Serie/Lote ya fue utilizada en este pedido');</script>");
                        return;
                    }
                }

                Panel6.Visible = true;
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
                if ((txtPrecioUnitario0.Text.Trim() == "" || txtPrecioUnitario0.Text.Trim() == "0") && ddTipo.SelectedValue != "Z")
                {
                    Response.Write("<script>window.alert('Debe Ingresar el PRECIO UNITARIO del producto');</script>");
                    return;
                }

                DataTable dt;
                if (Session["dt"] == null)
                {
                    dt = filldata();
                }
                else
                {
                    dt = (Session["dt"]) as DataTable;
                }
                DataRow Row1;
                Row1 = dt.NewRow();
                Row1["CodigoProducto"] = this.txtProducto.Text.Replace("<i>","").Replace("</i>","");
                Row1["DescProducto"] = Session["DescripLote"];
                Row1["FechaSolicitada"] = this.txtFechaSolicitada0.Text;
                Row1["Kilos"] = this.txtCantidad0.Text.Replace(".", ",");
                Row1["PrecioUnitario"] = this.txtPrecioUnitario0.Text.Replace(".", ",");
                Row1["PrecioLista"] = "0";
                Row1["Incremento"] = this.txtIncremento0.Text;
                Row1["BonificacionPorcentaje"] = this.txtBonificacionPorcentaje0.Text;
                Row1["LoteAVender"] = this.txtLoteAVender.Text;
                Row1["Autenticar_ProductoCobertura"] = "No";
                decimal TotalItem = Convert.ToDecimal(txtCantidad0.Text.Replace(".", ",")) * Convert.ToDecimal(txtPrecioUnitario0.Text.Replace(".", ","));
                decimal TotalIncre = 0;
                if (txtIncremento0.Text != "0")
                {
                    TotalItem = Math.Round(TotalItem + Convert.ToDecimal(txtIncremento0.Text.Replace(".", ",")) * TotalItem / 100, 3);
                    decimal Prec = Convert.ToDecimal(txtPrecioUnitario0.Text.Replace(".", ","));
                    TotalIncre = Math.Round(Prec + Convert.ToDecimal(txtIncremento0.Text.Replace(".", ",")) * Prec / 100, 3);
                }
                Row1["PrecioIncremento"] =TotalIncre;

                if (txtBonificacionPorcentaje0.Text != "0")
                    TotalItem = Math.Round(TotalItem - Convert.ToDecimal(txtBonificacionPorcentaje0.Text.Replace(".", ",")) * TotalItem / 100, 3);

                Row1["TotalItem"] = TotalItem;
                Row1["LoteAVender_Serie"] = txtSerieID.Text;
                Row1["LoteAVender_Lote"] = txtLoteID.Text;
                Row1["LoteAVenderCompleto"] = txtLoteAVenderCompleto.Text;
                Session["TotalPedido"] = Convert.ToDecimal(Session["TotalPedido"]) + TotalItem;
                lblPedidoTotal.Text = "TOTAL PEDIDO= " + Convert.ToString(Session["TotalPedido"]).Replace(",", ".") + "   " + ddMoneda.SelectedItem.Text.ToString();
                dt.Rows.Add(Row1);
                gwGrilla.DataSource = dt;
                gwGrilla.DataBind();
                Session["dt"] = dt;
                btnAceptarPedido.Visible = true;
                
                txtProducto.Text = "";
                txtFechaSolicitada0.Text = "";  //Convert.ToDateTime(TextBoxIni.Text).ToString("yyyy-MM-dd");
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
            }

        }

        protected void ddClientesPedidos_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (gwGrilla.Rows.Count > 0)
            {
                Response.Write("<script>window.alert('Hay productos ingresados para el cliente. Se borrará lo ingresado.');</script>");

                //Response.Write("<script language=javascript>if(confirm('Hay productos ingresados para el cliente. Se borrará lo ingresado.Continúa?')==true){ BorroTodo();}else { NoBorro();}</script>");
                //////Este mensaje muestra el mensaje de alerta directamente

                //ScriptManager.RegisterStartupScript(this,GetType(),"showalert","alert('Only alert Message');",true);
                //////Este mensaje muestra un mensaje de alerta de la función de JavaScript

                //ScriptManager.RegisterStartupScript(this, GetType(), "displayalertmessage", "Showalert();", true);


                //Borro Los datos de la grilla
                DataTable dt1 = Session["dt"] as DataTable;
                DataRow[] rows = dt1.Select();
                dt1.Rows.Remove(rows[0]);
                Session["dt"] = dt1;
                gwGrilla.DataSource = dt1;
                gwGrilla.DataBind();
                gwGrilla.DataSource = null;
                gwGrilla.DataBind();
            }
            else
            {
                Session["dt"] = null;
            }
            CargarComboDomiciliosEntrega();
            if(CBFacturaAnticipada.Checked)
            {
                Label16.Visible = true;
                ddFacturasAnticipadas.Visible = true;
                CargarComboFacturasAnticipadas();
            }
            else
            {
                Label16.Visible = false;
                ddFacturasAnticipadas.Visible = false;
            }
            ////busco datos Clientes
            if (ddTipo.SelectedValue == "Z")
            {
                ddTipoPago.SelectedValue = "0";
                ddTransportista.SelectedValue = "CA9690D2-DD76-4476-8C63-58BF140B5B8B";
            }
            else
            {
                SqlParameter[] unosParametros = null;
                DataSet unDS = null;
                Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
                SqlCommand cmd = new SqlCommand("dbo.SP_VT_TraerDatosCliente");
                try
                {
                    unosParametros = new SqlParameter[1];
                    unosParametros[0] = new SqlParameter("@Cliente_ID", System.Data.SqlDbType.VarChar);
                    unosParametros[0].Value = ddClientesPedidos.SelectedValue.ToString().Substring(0, 4).ToUpper();
                    unAcceso.AbrirConexion();
                    unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_VT_TraerDatosCliente"), unosParametros);

                    if (unDS.Tables[0].Rows.Count > 0)
                    {
                        if (unDS.Tables[0].Rows[0]["ID_TipoPagoCliente"].ToString() != null)
                        {
                            if (unDS.Tables[0].Rows[0]["ID_TipoPagoCliente"].ToString() != "")
                                ddTipoPago.SelectedValue = unDS.Tables[0].Rows[0]["ID_TipoPagoCliente"].ToString();
                            else
                                ddTipoPago.SelectedValue = "0";
                        }
                        else
                            ddTipoPago.SelectedValue = "0";
                        if (unDS.Tables[0].Rows[0]["ID_Transportista"].ToString() != "")
                            ddTransportista.SelectedValue = unDS.Tables[0].Rows[0]["ID_Transportista"].ToString();
                        else
                            ddTransportista.SelectedValue = "CA9690D2-DD76-4476-8C63-58BF140B5B8B";
                    }
                }
                finally
                {
                    unAcceso.CerrarConexion();
                }
            }
        }

        private void VerNumeroPedido(string Condi)
        {
            UltimoNumeroPedido = 0;
            //si Condi es 1:blanco   45: negro   90 : miti miti  70: ZStock
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlCommand cmd = new SqlCommand("dbo.SP_VT_BuscarNumeroPedidos");
            string Num = "";
            if (ddTipo.SelectedValue == "Z")
                Num = "70";
            else
                Num = ddCondicion.SelectedValue;
            try
            {
                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@Condicion", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Num;
                unosParametros[1] = new SqlParameter("@NroUltimo", System.Data.SqlDbType.Int);
                unosParametros[1].Direction = (ParameterDirection.Output);

                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(cmd, unosParametros);
                if (cmd.Parameters["@NroUltimo"].Value.ToString() == "")
                {
                    if (ddCondicion.SelectedValue.ToString() == "1")
                        UltimoNumeroPedido = 1;
                    else
                    {
                        if (ddCondicion.SelectedValue.ToString() == "45")
                            UltimoNumeroPedido = 45000;
                        else
                            UltimoNumeroPedido = 90000;
                    }
                }
                else
                    UltimoNumeroPedido = Convert.ToInt32(cmd.Parameters["@NroUltimo"].Value) + 1;
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        protected void ddProductoItem_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddTipo.SelectedValue == "Z")
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
                //unAcceso.ExecuteNonQuerySP(cmd, unosParametros);
                //txtPrecioLista.Text = Convert.ToString(cmd.Parameters["@PrecioFinal"].Value);
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_VT_TraerPrecios"),unosParametros);

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
                    txtPrecioLista.Text = Convert.ToString(Math.Round(Convert.ToDecimal(txtPrecioLista.Text.Replace(".", ",")), 3).ToString()).Replace(",",".");
                    txtPrecioUnitario.Text = Convert.ToString(Math.Round(Convert.ToDecimal(txtPrecioUnitario.Text.Replace(".", ",")), 3).ToString()).Replace(",", ".");
                }
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        protected void gwGrilla_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int index = Convert.ToInt32(e.RowIndex);
            string id = gwGrilla.DataKeys[index].Value.ToString();

            DataTable dt1 = Session["dt"] as DataTable;
            DataRow[] rows = dt1.Select("CodigoProducto = '" + id + "'");
            
            if (rows.Count() > 0)
            {
                Session["TotalPedido"] = Convert.ToDecimal(Session["TotalPedido"]) - Convert.ToDecimal(gwGrilla.Rows[index].Cells[12].Text.Replace(".", ","));
                lblPedidoTotal.Text = "TOTAL PEDIDO= " + Convert.ToString(Session["TotalPedido"]).Replace(",", ".") + "   " + ddMoneda.SelectedItem.Text.ToString();
                dt1.Rows.Remove(rows[0]);
            }

            Session["dt"] = dt1;

            gwGrilla.DataSource = dt1;
            gwGrilla.DataBind();
            if (gwGrilla.Rows.Count > 0)
                btnAceptarPedido.Visible = true;
        }

        protected void gwGrilla_SelectedIndexChanged(object sender, EventArgs e)
        {
           
        }

      

        protected void ddTipo_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddTipo.SelectedValue == "Z")
            {
                //pedido>70000
                ddCondicion.Visible = false;
                ddMoneda.Visible = false;
                ddTipoPago.Visible = false;
                txtOrdenCompra.Visible = false;
                ddTransportista.Visible = false;
                ddDomicilioEntrega.Visible = false;
                ddFacturasAnticipadas.Visible = false;
                txtFechaSolicitada.Visible = false;
                txtPrecioLista.Visible = false;
                txtPrecioUnitario.Visible = false;
                txtIncremento.Visible = false;
                txtBonificacionPorcentaje.Visible = false;
                txtLoteAVender.Visible = false;


                Label5.Visible = false;
                Label8.Visible = false;
                Label15.Visible = false;
                Label4.Visible = false;
                Label14.Visible = false;
                Label13.Visible = false;
                Label16.Visible = false;
                Label10.Visible = false;
                Label7.Visible = false;
                Label9.Visible = false;
                Label18.Visible = false;
                Label20.Visible = false;
                Label21.Visible = false;
                if (CBLotesAVender.Checked)
                {
                    Label21.Visible = true;
                    txtLoteAVender.Visible = true;
                    LblLoteAVender.Visible = true;
                }
            }
            else
            {
                ddCondicion.Visible = true;
                ddMoneda.Visible = true;
                ddTipoPago.Visible = true;
                txtOrdenCompra.Visible = true;
                ddTransportista.Visible = true;
                ddDomicilioEntrega.Visible = true;
                ddFacturasAnticipadas.Visible = false;
                txtFechaSolicitada.Visible = true;
                txtPrecioLista.Visible = true;
                txtPrecioLista.Enabled = false;
                txtPrecioUnitario.Visible = true;
                txtIncremento.Visible = true;
                txtBonificacionPorcentaje.Visible = true;
                txtLoteAVender.Visible = true;

                Label5.Visible = true;
                Label8.Visible = true;
                Label15.Visible = true;
                Label4.Visible = true;
                Label14.Visible = true;
                Label13.Visible = true;
                Label16.Visible = false;
                Label10.Visible = true;
                Label7.Visible = true;
                Label9.Visible = true;
                Label18.Visible = true;
                Label20.Visible = true;
                Label21.Visible = true;
            }
        }

        protected void txtLoteAVender_TextChanged(object sender, EventArgs e)
        {
            if (txtLoteAVender.Text.Trim() == "") // || txtLoteAVender.Text.Trim().Length < 9)
                return;
            if (txtLoteAVender.Text.Trim() == Session["LoteIngresada"].ToString())
                return;
            Session["LoteIngresada"]  = txtLoteAVender.Text.Trim();
            //BuscoProducto
            txtLoteID.Text = "";
            txtSerieID.Text = "";
            txtLoteAVenderCompleto.Text = "";
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
                    LblLoteAVender.Text = "Prod: " + unDS.Tables[0].Rows[0].ItemArray[1].ToString() + "<br>" +
                                          " Cant.: " + Math.Round(Convert.ToDecimal(unDS.Tables[0].Rows[0].ItemArray[2].ToString()), 2).ToString() + "<br>" +
                                          " Cant.No Lineal: " +  Math.Round(Convert.ToDecimal(unDS.Tables[0].Rows[0].ItemArray[3].ToString()),2).ToString();
                    //" Bultos: " + unDS.Tables[0].Rows[0].ItemArray[3].ToString() + "<br>" +
                    Session["DescripLote"] = unDS.Tables[0].Rows[0].ItemArray[1].ToString();
                    txtCantidad0.Text = Math.Round(Convert.ToDecimal(unDS.Tables[0].Rows[0].ItemArray[2].ToString()), 2).ToString().Replace(",",".");
                    if (ddTipo.SelectedValue == "F")
                        txtCantidad0.Enabled = true;
                    else
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

        protected void CBInhabilitaFiltro_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void CBLotesAVender_CheckedChanged(object sender, EventArgs e)
        {
            if (gwGrilla.Rows.Count > 0)
            {
                DataTable dt1 = Session["dt"] as DataTable;
                DataRow[] rows = dt1.Select();
                int cc = dt1.Rows.Count;
                for (int k = 0; k < cc; k++)
                {
                    dt1.Rows.Remove(rows[k]);
                }
                Session["dt"] = dt1;
                gwGrilla.DataSource = dt1;
                gwGrilla.DataBind();
                Session["TotalPedido"] = "0";
            }
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            LimpiarCampos();
            //c:\0-proyectos\intranet\sintecromnet\paginas\vt_ingresopedidos.aspx
            //Response.Redirect("~/VT_IngresoPedidos.aspx?ReturnUrl=" + HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]));

            ddTipo.Focus();
        }


    }

       
}
