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
    public partial class INV_IngresoInventario : System.Web.UI.Page
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

                    if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_GERENTES" || group == "DOMINIOW_INVENTARIO")
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
                    //CargarDepositos();
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
                unosParametros = new SqlParameter[1];
               
               

                unosParametros[0] = new SqlParameter("@SL", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = txtBSerie.Text;

               
               

               
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

        private void TraerGrid(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[1];

                               
                unosParametros[0] = new SqlParameter("@Producto", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = txtProducto.Text;




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

        private void VerificarPendiente(string nombreStored, string Lote_ID)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[1];


                unosParametros[0] = new SqlParameter("@Lote_ID", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Lote_ID;




                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);
                DataTable dt = unDS.Tables[0].Copy();

                if (dt.Rows.Count > 0)
                {
                    Response.Write("<script>window.alert('Existen Transacciones Pendientes de Proceso para la Serie-Lote Seleccionada');</script>");
                    Panel2.Visible = false;
                }
                else
                {
                    Panel1.Visible = true;
                    Panel2.Visible = false;

                    CargarDepositosID();
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


            }
           
        }

        protected void ButtonVer_Click(object sender, EventArgs e)
        {
           Panel2.Visible = true;
            if (ddTipo.SelectedValue=="0")
            {
                gwGrilla.Visible = true;
                GridView1.Visible = false;
                this.TraerGrilla(gwGrilla, "dbo.SP_INV_TraerInventarioIngresoSL");
            }
            else
            {
                gwGrilla.Visible = false;
                GridView1.Visible = true;
                this.TraerGrid(GridView1, "dbo.SP_INV_TraerInventarioIngresoPROD");
            }
   

        }

        public void CargarDepositosID()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_INV_TraerComboDepositosID"));

                DropDownList3.DataSource = unDS;
                DropDownList3.DataValueField = "ID";
                DropDownList3.DataTextField = "Nombre";
                DropDownList3.DataBind();
                //DropDownList2.Items.Insert(0, new ListItem("Todos", "999"));

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

     
      

        protected void gwGrilla_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Detalle")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                               
               

                lblDetalle1.Text = (this.gwGrilla.DataKeys[index].Values[0]).ToString();
                lblDetalle2.Text = (Convert.ToInt64(this.gwGrilla.DataKeys[index].Values[1])).ToString();

                Session["DEPOSITO_ID"] = this.gwGrilla.DataKeys[index].Values[2].ToString();
                Session["PRODUCTO_ID"] = this.gwGrilla.DataKeys[index].Values[3].ToString();
                Session["SERIE_ID"] = this.gwGrilla.DataKeys[index].Values[4].ToString();
                Session["LOTE_ID"] = this.gwGrilla.DataKeys[index].Values[5].ToString();

                this.VerificarPendiente("SP_INV_ValidarTransaccionPendiente", this.gwGrilla.DataKeys[index].Values[5].ToString());
               

            }
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Panel1.Visible = false;
            Panel2.Visible = true;
        }

        private void InsertarDatos(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlCommand cmd = new SqlCommand(nombreSP);

            try
            {
                unosParametros = new SqlParameter[8];

                unosParametros[0] = new SqlParameter("@DepositoDes", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = DropDownList3.SelectedValue.ToString();

                unosParametros[1] = new SqlParameter("@Producto_ID", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = Session["PRODUCTO_ID"].ToString();

                if (ddTipo.SelectedValue == "0")
                {
                    unosParametros[2] = new SqlParameter("@Serie_ID", System.Data.SqlDbType.VarChar);
                    unosParametros[2].Value = Session["SERIE_ID"].ToString();
                }
                else
                {
                    unosParametros[2] = new SqlParameter("@Serie_ID", System.Data.SqlDbType.VarChar);
                    unosParametros[2].Value = "";

                }

                if (ddTipo.SelectedValue == "0")
                {
                    unosParametros[3] = new SqlParameter("@Lote_ID", System.Data.SqlDbType.VarChar);
                    unosParametros[3].Value = Session["LOTE_ID"].ToString();
                }
                else
                {
                    unosParametros[3] = new SqlParameter("@Lote_ID", System.Data.SqlDbType.VarChar);
                    unosParametros[3].Value = "";
                }
               

                unosParametros[4] = new SqlParameter("@Cantidad", System.Data.SqlDbType.Int);
                unosParametros[4].Value = Convert.ToInt32(txtCantidad.Text);

                if (ddTipo.SelectedValue == "0")
                {
                    unosParametros[5] = new SqlParameter("@Crealote", System.Data.SqlDbType.Int);
                    unosParametros[5].Value = 0;
                }
                else
                {
                    unosParametros[5] = new SqlParameter("@Crealote", System.Data.SqlDbType.Int);
                    unosParametros[5].Value = 1;
                }

                unosParametros[6] = new SqlParameter("@Detalle", System.Data.SqlDbType.VarChar);
                unosParametros[6].Value = txtDetalle.Text;               

                unosParametros[7] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[7].Value = Session["Usr"].ToString();



                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(cmd, unosParametros);




            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

       

        protected void btnCerrar0_Click(object sender, EventArgs e)
        {
            this.InsertarDatos("dbo.SP_INV_InsertarTRIngresoInventario");
            Panel1.Visible = false;
            Panel2.Visible = false;
            ddTipo.SelectedIndex = 0;
            txtBSerie.Text = "";
            txtProducto.Text = "";
            lblPedido5.Visible = false;
            txtBSerie.Visible = false;
            btnVer0.Visible = false;
            lblPedido6.Visible = false;
            txtProducto.Visible = false;
        }

        protected void ddTipo_SelectedIndexChanged(object sender, EventArgs e)
        {
           int respuesta = Convert.ToInt16(ddTipo.SelectedValue);
           switch (respuesta)
           {
               case 0:
                   lblPedido5.Visible = true;
                   txtBSerie.Visible = true;
                   btnVer0.Visible = true;
                   lblPedido6.Visible = false;
                   txtProducto.Visible = false;
                   break;
               case 1:
                    lblPedido5.Visible = false;
                    txtBSerie.Visible = false;
                    btnVer0.Visible = true;
                    lblPedido6.Visible = true;
                    txtProducto.Visible = true;
                   break;
               case 2:
                   lblPedido5.Visible = false;
                   txtBSerie.Visible = false;
                   btnVer0.Visible = false;
                   lblPedido6.Visible = false;
                   txtProducto.Visible = false;
                   Panel1.Visible = false;
                   Panel2.Visible = false;
                   break;


           }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Detalle")
            {
                int index = Convert.ToInt32(e.CommandArgument);

                Panel1.Visible = true;
                Panel2.Visible = false;


                lblDetalle1.Text = "Se va a Generar una Nuevo Lote";
                lblDetalle2.Text = "A Ingresar";

                Session["PRODUCTO_ID"] = this.GridView1.DataKeys[index].Values[0].ToString();
                
                CargarDepositosID();

            }
        }
            

    }

       
}
