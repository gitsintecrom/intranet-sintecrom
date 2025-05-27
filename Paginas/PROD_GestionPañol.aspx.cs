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
    public partial class PROD_GestionPañol : System.Web.UI.Page
    {
        //public decimal calculo { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["Accede"] = "NO";

                IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                foreach (IdentityReference i in irc)
                {
                    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                    if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES") || group == ("DOMINIOW_PANIOL"))
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

                    this.TraerGrilla(gwGrilla, "SP_PROD_TraerInsumos");
                    CargarComboRubro();

                }

            }
        }


        protected void btnEjecutar_Click(object sender, EventArgs e)
        {
            if(Session["Accion"].ToString() == "A")
            {
                this.InsertarDatos("dbo.SP_PROD_InsertarInsumos");
                LimpiarCampos();
                Response.Write("<script>window.confirm('El Insumo ha Sido Ingresado Exitosamente');</script>");
                LimpiarCampos();
                Panel1.Visible = false;
                Panel2.Visible = true;
                this.TraerGrilla(gwGrilla, "SP_PROD_TraerInsumos");
                
            }

            else
            {
                if (Session["Accion"].ToString() == "M")
                {
                    this.EditarInsumo("dbo.SP_PROD_EditarInsumos");
                    LimpiarCampos();
                    Panel1.Visible = false;
                    Panel2.Visible = true;
                    this.TraerGrilla(gwGrilla, "SP_PROD_TraerInsumos");
                }
               
            }
           
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            LimpiarCampos();
            Panel1.Visible = false;
            Panel2.Visible = true;
        }

        private void TraerGrilla(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            //SqlParameter[] unosParametros = null;

            try
            {


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));

                //foreach (DataTable table in unDS.Tables)
                //{
                //    foreach (DataRow dr in table.Rows)
                //    {
                //        string codigo = dr["codigo"].ToString();
                        
                       
                //    }
                //}


                unGrid.DataSource = unDS;

                unGrid.DataBind();


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerGrillaInsumos(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            //SqlParameter[] unosParametros = null;

            try
            {


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));

                //foreach (DataTable table in unDS.Tables)
                //{
                //    foreach (DataRow dr in table.Rows)
                //    {
                //        string codigo = dr["codigo"].ToString();


                //    }
                //}


                unGrid.DataSource = unDS;

                unGrid.DataBind();


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void CargarComboRubro()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_PROD_TraerComboRubros"));

                ddRubro.DataSource = unDS;
                ddRubro.DataValueField = "Codigo";
                ddRubro.DataTextField = "Nombre";
                ddRubro.DataBind();
                //ddRubro.Items.Insert(0, new ListItem("Seleccione...", ""));

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }


        private void InsertarDatos(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[15];


               
                unosParametros[0] = new SqlParameter("@Codigo", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = txtCodigo.Text.Trim();

                unosParametros[1] = new SqlParameter("@Descripcion", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = txtDescripcion.Text.Trim();

                unosParametros[2] = new SqlParameter("@Ubicacion", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = txtUbicacion.Text.Trim();

                unosParametros[3] = new SqlParameter("@Reposicion", System.Data.SqlDbType.Decimal);
                unosParametros[3].Value = txtReposicion.Text.Replace(".", ",");

                unosParametros[4] = new SqlParameter("@Consumo", System.Data.SqlDbType.Decimal);
                unosParametros[4].Value = txtConsumo.Text.Replace(".", ",") ;

                unosParametros[5] = new SqlParameter("@Requerimiento", System.Data.SqlDbType.VarChar);
                unosParametros[5].Value = DropDownList1.SelectedValue;

                unosParametros[6] = new SqlParameter("@TiempoCompra", System.Data.SqlDbType.Int);
                unosParametros[6].Value = txtTiempo.Text.Trim();

                unosParametros[7] = new SqlParameter("@UnidadMedida", System.Data.SqlDbType.VarChar);
                unosParametros[7].Value = DropDownList2.SelectedValue;

                unosParametros[8] = new SqlParameter("@Observaciones", System.Data.SqlDbType.VarChar);
                unosParametros[8].Value = txtObservaciones.Text.Trim();

                unosParametros[9] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[9].Value = Session["Usr"].ToString();

                unosParametros[10] = new SqlParameter("@Valor", System.Data.SqlDbType.Decimal);
                unosParametros[10].Value = txtValor.Text.Replace(".", ",");

                unosParametros[11] = new SqlParameter("@Moneda", System.Data.SqlDbType.VarChar);
                unosParametros[11].Value = DropDownList3.SelectedValue;

                unosParametros[12] = new SqlParameter("@Cotizacion", System.Data.SqlDbType.Decimal);
                unosParametros[12].Value = txtCotizacion.Text.Replace(".", ",");

                unosParametros[13] = new SqlParameter("@RubroID", System.Data.SqlDbType.Int);
                unosParametros[13].Value = ddRubro.SelectedValue;

                unosParametros[14] = new SqlParameter("@Vencimiento", System.Data.SqlDbType.DateTime);
                unosParametros[14].Value = txtVenci.Text;



                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

        private void EditarInsumo(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[16];

                unosParametros[0] = new SqlParameter("@ID", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt32(Session["ID"]);

                unosParametros[1] = new SqlParameter("@Codigo", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = txtCodigo.Text.Trim();

                unosParametros[2] = new SqlParameter("@Descripcion", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = txtDescripcion.Text.Trim();

                unosParametros[3] = new SqlParameter("@Ubicacion", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = txtUbicacion.Text.Trim();


                unosParametros[4] = new SqlParameter("@Reposicion", System.Data.SqlDbType.Decimal);
                unosParametros[4].Value = txtReposicion.Text.Replace(".", ",");

                unosParametros[5] = new SqlParameter("@Consumo", System.Data.SqlDbType.Decimal);
                unosParametros[5].Value = (txtConsumo.Text.Replace(".",","));

                unosParametros[6] = new SqlParameter("@Requerimiento", System.Data.SqlDbType.VarChar);
                unosParametros[6].Value = DropDownList1.SelectedValue;

                unosParametros[7] = new SqlParameter("@TiempoCompra", System.Data.SqlDbType.Int);
                unosParametros[7].Value = txtTiempo.Text.Trim();


                unosParametros[8] = new SqlParameter("@UnidadMedida", System.Data.SqlDbType.VarChar);
                unosParametros[8].Value = DropDownList2.SelectedValue;

                unosParametros[9] = new SqlParameter("@Observaciones", System.Data.SqlDbType.VarChar);
                unosParametros[9].Value = txtObservaciones.Text.Trim();

                unosParametros[10] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[10].Value = Session["Usr"].ToString();

                unosParametros[11] = new SqlParameter("@Valor", System.Data.SqlDbType.Decimal);
                unosParametros[11].Value = txtValor.Text.Replace(".", ","); 

                unosParametros[12] = new SqlParameter("@Moneda", System.Data.SqlDbType.VarChar);
                unosParametros[12].Value = DropDownList3.SelectedValue;

                unosParametros[13] = new SqlParameter("@Cotizacion", System.Data.SqlDbType.Decimal);
                unosParametros[13].Value = txtCotizacion.Text.Replace(".", ",");

                unosParametros[14] = new SqlParameter("@RubroID", System.Data.SqlDbType.Int);
                unosParametros[14].Value = ddRubro.SelectedValue;

                if(txtVenci.Text == "")
                {
                    unosParametros[15] = new SqlParameter("@Vencimiento", System.Data.SqlDbType.DateTime);
                    unosParametros[15].Value = "31/12/2100";
                }
                else
                {
                    unosParametros[15] = new SqlParameter("@Vencimiento", System.Data.SqlDbType.DateTime);
                    unosParametros[15].Value = txtVenci.Text;
                }
                



                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);


            }
            finally
            {
                unAcceso.CerrarConexion();

            }

        }

        private void SuspenderInsumo(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@ID", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt32(Session["ID"]);



                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);

            }
            finally
            {
                unAcceso.CerrarConexion();

            }

        }



        private void LimpiarCampos()
        {
            txtCodigo.Text = "";
            txtDescripcion.Text = "";
            txtUbicacion.Text = "";
            txtReposicion.Text = "0";
            txtConsumo.Text = "0";
            DropDownList1.SelectedValue = "Si";
            txtTiempo.Text = "";
            DropDownList2.SelectedValue = "Unidades";
            txtObservaciones.Text = "";

        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Session["Accion"] = "A";
            Panel1.Visible = true;
        }

        protected void gwGrilla_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Editar")           
            {
                gwGrillaProducto.Visible = false;
                int index = Convert.ToInt32(e.CommandArgument);
                Panel1.Visible = true;
                Session["ID"] = this.gwGrilla.DataKeys[index].Values[0].ToString();
                Session["Accion"] = "M";
                Label1.Text = "Editar Insumo";
                txtCodigo.Text = this.gwGrilla.DataKeys[index].Values[1].ToString();
                txtDescripcion.Text = this.gwGrilla.DataKeys[index].Values[2].ToString();
                txtUbicacion.Text = this.gwGrilla.DataKeys[index].Values[3].ToString();
                txtReposicion.Text = this.gwGrilla.DataKeys[index].Values[4].ToString().Replace(",", ".");
                txtConsumo.Text = this.gwGrilla.DataKeys[index].Values[5].ToString().Replace(",",".");
                DropDownList1.SelectedValue = this.gwGrilla.DataKeys[index].Values[6].ToString();
                txtTiempo.Text = this.gwGrilla.DataKeys[index].Values[7].ToString();
                DropDownList2.SelectedValue = this.gwGrilla.DataKeys[index].Values[8].ToString();
                txtObservaciones.Text = this.gwGrilla.DataKeys[index].Values[9].ToString();
                txtValor.Text = this.gwGrilla.DataKeys[index].Values[10].ToString().Replace(",", ".");
                DropDownList3.SelectedValue = this.gwGrilla.DataKeys[index].Values[11].ToString();
                txtCotizacion.Text = this.gwGrilla.DataKeys[index].Values[12].ToString().Replace(",", ".");
                ddRubro.SelectedValue = this.gwGrilla.DataKeys[index].Values[13].ToString();
                if (!String.IsNullOrEmpty(this.gwGrilla.DataKeys[index].Values[14].ToString()))
                    {
                        DateTime dat = Convert.ToDateTime(this.gwGrilla.DataKeys[index].Values[14].ToString());
                        txtVenci.Text = String.Format("{0:yyyy-MM-dd}", dat);
                    }
        





                Panel2.Visible = false;

            }

            if (e.CommandName == "Eliminar")
            {


                int index = Convert.ToInt32(e.CommandArgument);
                Panel1.Visible = true;
                Session["ID"] = this.gwGrilla.DataKeys[index].Values[0].ToString();
                Session["Accion"] = "B";
                this.SuspenderInsumo("dbo.SP_PROD_SuspenderInsumos");
                this.TraerGrilla(gwGrilla, "SP_PROD_TraerInsumos");

               


            }
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
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

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= InventarioInsumos.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Session["Accion"] = "A";
            Panel1.Visible = true;
            Panel2.Visible = false;
            Label1.Text = "Ingrese nuevo Insumo";
            gwGrillaProducto.Visible = true;
            this.TraerGrillaInsumos(gwGrillaProducto, "SP_PROD_NuevosInsumosPaniol");
            txtCodigo.ReadOnly = true;
            txtDescripcion.ReadOnly = true;
            alta.Visible = false;
        }

        protected void gwGrillaProducto_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            txtCodigo.Text = this.gwGrillaProducto.DataKeys[index].Values[0].ToString();
            txtDescripcion.Text = this.gwGrillaProducto.DataKeys[index].Values[1].ToString();
            gwGrillaProducto.Visible = false;
            alta.Visible = true;
        }
    }

       
}
