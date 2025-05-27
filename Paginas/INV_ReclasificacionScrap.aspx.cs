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
    public partial class INV_ReclasificacionScrap : System.Web.UI.Page
    {
        //int ddKilos = 0;
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
                    //CargarDepositosID();
                    CargarProductosID();
                    ddProducto.SelectedIndex = ddProducto.Items.IndexOf(ddProducto.Items.FindByValue("x")); // If you want to find text by value field.

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
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_INV_TraerComboDepositosFiltrado"));

                DropDownList2.DataSource = unDS;
                DropDownList2.DataValueField = "Codigo";
                DropDownList2.DataTextField = "Nombre";
                DropDownList2.DataBind();
                DropDownList2.Items.Insert(0, new ListItem("Todos", "999"));

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

       

        public void CargarProductosID()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;
            


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_INV_TraerComboProductosScrap"));

                ddProducto.DataSource = unDS;
                ddProducto.DataValueField = "ID";
                ddProducto.DataTextField = "Codigo";
                ddProducto.DataBind();
                ddProducto.Items.Insert(0, new ListItem("Seleccione", ""));
                //ClientScript.RegisterStartupScript(this.GetType(), "Loading", "ShowProgress();", true);
                //ClientScript.RegisterStartupScript(this.GetType(), "load", script, true);



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
            this.TraerGrilla(gwGrilla, "dbo.SP_INV_TraerGrillaReclasificacion");
            //CargarProductosID();

            Panel2.Visible = true;
        }

     
      

        protected void gwGrilla_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Detalle")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                               
                //Panel1.Visible = true;
                //Panel2.Visible = false;


                lblDetalle1.Text = (this.gwGrilla.DataKeys[index].Values[0]).ToString();
                Session["Cantidad"] = Convert.ToInt32(this.gwGrilla.DataKeys[index].Values[1]);
                lblDetalle2.Text = (this.gwGrilla.DataKeys[index].Values[6]).ToString();

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
                unosParametros = new SqlParameter[9];

                unosParametros[0] = new SqlParameter("@DepositoOri", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["DEPOSITO_ID"].ToString();

                unosParametros[1] = new SqlParameter("@Producto_Egresar_ID", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = Session["PRODUCTO_ID"].ToString();

                unosParametros[2] = new SqlParameter("@Producto_Ingresar_ID", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = ddProducto.SelectedValue;

                unosParametros[3] = new SqlParameter("@Serie_ID", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = Session["SERIE_ID"].ToString();

                unosParametros[4] = new SqlParameter("@Lote_ID", System.Data.SqlDbType.VarChar);
                unosParametros[4].Value = Session["LOTE_ID"].ToString();

                unosParametros[5] = new SqlParameter("@Cantidad", System.Data.SqlDbType.Int);
                unosParametros[5].Value = Session["Cantidad"];

                unosParametros[6] = new SqlParameter("@DepositoDes", System.Data.SqlDbType.VarChar);
                unosParametros[6].Value = Session["DEPOSITO_ID"].ToString();

                unosParametros[7] = new SqlParameter("@Detalle", System.Data.SqlDbType.VarChar);
                unosParametros[7].Value = ddMotivo.SelectedValue;               

                unosParametros[8] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[8].Value = Session["Usr"].ToString();



                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(cmd, unosParametros);




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

                   
                }

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }


       

        protected void btnCerrar0_Click(object sender, EventArgs e)
        {
            this.InsertarDatos("dbo.SP_INV_InsertarTRReclasificacion");
            Panel1.Visible = false;
            Panel2.Visible = false;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
          

        }

        protected void gwGrilla_RowDataBound1(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //Button btnExport = e.Row.FindControl("Button1") as Button;
                //if (btnExport != null)
                //{
                //    ((ScriptManager)this.Page.Master.FindControl("ID of your Script manager")).RegisterPostBackControl(downloadDocColumn);
                //    // In Above line i assumed Script Manager is placed on Your master page.
                //}
            }
        }
            

    }

       
}
