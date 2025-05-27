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
    public partial class VT_ReservaMP : System.Web.UI.Page
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
                    CargarDepositos();
                    //theDiv.Visible = false;
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
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_VT_TraerComboDepositosReserva"));

                DropDownList2.DataSource = unDS;
                DropDownList2.DataValueField = "Codigo";
                DropDownList2.DataTextField = "Nombre";
                DropDownList2.DataBind();
                //DropDownList2.Items.Insert(0, new ListItem("Todos", "999"));

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        public void CargarDepositosID()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_VT_TraerClienteReserva"));

                DropDownList3.DataSource = unDS;
                DropDownList3.DataValueField = "ID";
                DropDownList3.DataTextField = "Denominacion";
                DropDownList3.DataBind();
                //DropDownList2.Items.Insert(0, new ListItem("Todos", "999"));

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
            this.TraerGrilla(gwGrilla, "dbo.SP_INV_TraerTransferenciaInventario");
           Panel2.Visible = true;
        }

     
      

        protected void gwGrilla_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Detalle")
            {
                int index = Convert.ToInt32(e.CommandArgument);

                Panel1.Visible = true;
                Panel2.Visible = false;


                lblDetalle1.Text = (this.gwGrilla.DataKeys[index].Values[0]).ToString();
                lblDetalle2.Text = (Convert.ToInt64(this.gwGrilla.DataKeys[index].Values[1])).ToString();

                Session["DEPOSITO_ID"] = this.gwGrilla.DataKeys[index].Values[2].ToString();
                Session["PRODUCTO_ID"] = this.gwGrilla.DataKeys[index].Values[3].ToString();
                Session["SERIE_ID"] = this.gwGrilla.DataKeys[index].Values[4].ToString();
                Session["LOTE_ID"] = this.gwGrilla.DataKeys[index].Values[5].ToString();

                CargarDepositosID();

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
                unosParametros = new SqlParameter[9];

                unosParametros[0] = new SqlParameter("@Ciente_id", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = DropDownList3.SelectedValue;                

                unosParametros[1] = new SqlParameter("@Lote_ID", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = Session["LOTE_ID"].ToString();

                unosParametros[2] = new SqlParameter("@Cantidad", System.Data.SqlDbType.Int);
                unosParametros[2].Value = Convert.ToInt32(lblDetalle2.Text);               

                unosParametros[3] = new SqlParameter("@Detalle", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = txtDetalle.Text;               

                unosParametros[4] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[4].Value = Session["Usr"].ToString();

                unosParametros[5] = new SqlParameter("@DepositoOri", System.Data.SqlDbType.VarChar);
                unosParametros[5].Value = Session["DEPOSITO_ID"].ToString();

                unosParametros[6] = new SqlParameter("@Producto_ID", System.Data.SqlDbType.VarChar);
                unosParametros[6].Value = Session["PRODUCTO_ID"].ToString();

                unosParametros[7] = new SqlParameter("@SERIE_ID", System.Data.SqlDbType.VarChar);
                unosParametros[7].Value = Session["SERIE_ID"].ToString();

                unosParametros[8] = new SqlParameter("@FechaHasta", System.Data.SqlDbType.DateTime);
                unosParametros[8].Value = Convert.ToDateTime(TextBoxFin.Text);

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
            this.InsertarDatos("dbo.SP_VT_InsertarReservaMP");
            Panel1.Visible = false;
            Panel2.Visible = false;
        }
            

    }

       
}
