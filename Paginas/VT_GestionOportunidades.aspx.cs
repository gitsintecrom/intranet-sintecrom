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
    public partial class VT_GestionOportunidades : System.Web.UI.Page
    {
        //public DataSet unDsGw = null;

        protected void Page_Load(object sender, EventArgs e)
        {
           
            if (!IsPostBack)
            {

                Session["Accede"] = "NO";

                IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                foreach (IdentityReference i in irc)
                {
                    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                    if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES"))
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
                    
                    CargarComboFamilia();
                    CargarComboEspesor();
                    CargarComboAleacion();
                    CargarComboTemple();
                    CargarComboForma();
                    CargarComboTerminacion();
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
                unosParametros = new SqlParameter[6];


                unosParametros[0] = new SqlParameter("@Familia", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value =ddFamilia.SelectedValue;

                unosParametros[1] = new SqlParameter("@Espesor", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = ddEspesor.SelectedValue;

                unosParametros[2] = new SqlParameter("@Aleacion", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = ddAleacion.SelectedValue;

                unosParametros[3] = new SqlParameter("@Temple", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = ddTemple.SelectedValue;

                unosParametros[4] = new SqlParameter("@Forma", System.Data.SqlDbType.VarChar);
                unosParametros[4].Value = ddForma.SelectedValue;

                unosParametros[5] = new SqlParameter("@Terminacion", System.Data.SqlDbType.VarChar);
                unosParametros[5].Value = ddTerminacion.SelectedValue;

               
                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);

                Session["unDS"] = unDS;

                unGrid.DataSource = unDS;
                unGrid.DataBind();
              

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }



        private void CargarComboTerminacion()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_VT_TraerComboTerminacion"));

                ddTerminacion.DataSource = unDS;
                ddTerminacion.DataValueField = "Codigo";
                ddTerminacion.DataTextField = "Descripcion";
                ddTerminacion.DataBind();
                ddTerminacion.Items.Insert(0, new ListItem("Seleccione...", ""));

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            this.TraerGrilla(gwGrilla, "dbo.SP_VT_GestionOportunidades");
            Mensaje.Visible = false;
            if(gwGrilla.Rows.Count > 0)
                LinkButton3.Visible = true;
            else
                LinkButton3.Visible = false;


        }

        protected void gwGrilla_RowDataBound2(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                Button bEstado = (Button)e.Row.FindControl("Button1");


                if (bEstado.Text == "Si")
                {
                    bEstado.BackColor = System.Drawing.Color.Green;

                }
                else
                {
                    bEstado.BackColor = System.Drawing.Color.FromArgb(255, 0, 0);
                    bEstado.Enabled = false;
                }


            }             
                    
        }

        private void ActualizarEstado(string nombreStored, string sPrecio)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@Lote_ID", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["Lote_ID"].ToString();

                unosParametros[1] = new SqlParameter("@Precio", System.Data.SqlDbType.Decimal);
                unosParametros[1].Value = Convert.ToDecimal(sPrecio.ToString().Replace(".",","));

              
                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreStored), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

      

      

        protected void gwGrilla_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //if (e.CommandName == "editar")
            //{
            //    gwGrilla.Visible = false;
            //    EditarPrecio.Visible = true;
               
            //    int index = Convert.ToInt32(e.CommandArgument);           
                
            //    Session["Lote_ID"]  = (this.gwGrilla.DataKeys[index].Values[0]).ToString();

            //    decimal dPrecio = Convert.ToDecimal(this.gwGrilla.DataKeys[index].Values[1]);
            //    txtPrecio.Text = dPrecio.ToString("0.000");


            //}

            if (e.CommandName == "Estado")
            {
                //gwGrilla.Visible = false;
                Mensaje.Visible = true;

                string sNotaCalidad = (e.CommandArgument as string);
                //int index = Convert.ToInt32(e.CommandArgument);

                //Session["Nota"] = (this.gwGrilla.DataKeys[index].Values[0]).ToString();

                Label5.Text = sNotaCalidad;



            }
           
        }

        private void CargarComboFamilia()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_VT_TraerComboFamilia"));

                ddFamilia.DataSource = unDS;
                ddFamilia.DataValueField = "Codigo";
                ddFamilia.DataTextField = "Descripcion";
                ddFamilia.DataBind();
                ddFamilia.Items.Insert(0, new ListItem("Seleccione...", ""));

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void CargarComboEspesor()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_VT_TraerComboEspesor"));

                ddEspesor.DataSource = unDS;
                ddEspesor.DataValueField = "Codigo";
                ddEspesor.DataTextField = "Descripcion";
                ddEspesor.DataBind();
                ddEspesor.Items.Insert(0, new ListItem("Seleccione...", ""));

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void CargarComboAleacion()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_VT_TraerComboAleacion"));

                ddAleacion.DataSource = unDS;
                ddAleacion.DataValueField = "Codigo";
                ddAleacion.DataTextField = "Descripcion";
                ddAleacion.DataBind();
                ddAleacion.Items.Insert(0, new ListItem("Seleccione...", ""));

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void CargarComboTemple()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_VT_TraerComboTemple"));

                ddTemple.DataSource = unDS;
                ddTemple.DataValueField = "Codigo";
                ddTemple.DataTextField = "Descripcion";
                ddTemple.DataBind();
                ddTemple.Items.Insert(0, new ListItem("Seleccione...", ""));

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void CargarComboForma()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_VT_TraerComboForma"));

                ddForma.DataSource = unDS;
                ddForma.DataValueField = "Codigo";
                ddForma.DataTextField = "Descripcion";
                ddForma.DataBind();
                ddForma.Items.Insert(0, new ListItem("Seleccione...", ""));

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }



        protected void btnAceptar_Click(object sender, EventArgs e)
        {            
            DataSet dss = (DataSet)Session["unDS"];
            int icant = 0;
            foreach (DataRow dr in dss.Tables[0].Rows)
            {
                Session["Lote_ID"] = dr["LOTE_ID"].ToString();
                string valor = txtPrecioMasivo.Text;
                string sl = dr["SL"].ToString();
                this.ActualizarEstado("dbo.SP_VT_EditarInventarioOportunidades", valor);
                icant = icant + 1;

                //string valor2 = dr[0].ToString();
            }
            Label6.Visible = true;
            Label6.Text = "Se han Actualizado " + icant + " Precios";
            this.TraerGrilla(gwGrilla, "dbo.SP_VT_GestionOportunidades");


        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            //gwGrilla.Visible = true;
            Masivo.Visible = false;
            Label6.Visible = false;
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            Mensaje.Visible = false;

        }

      

      

        protected void gwGrilla_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gwGrilla.EditIndex = e.NewEditIndex;
            Session["Lote_ID"] = (this.gwGrilla.DataKeys[e.NewEditIndex].Values[0]).ToString();
            this.TraerGrilla(gwGrilla, "dbo.SP_VT_GestionOportunidades");
            gwGrilla.Rows[e.NewEditIndex].FindControl("txtPrecio").Focus();


        }



        protected void gwGrilla_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow fila = gwGrilla.Rows[e.RowIndex];
            string valor = (fila.FindControl("txtPrecio") as TextBox).Text;
            this.ActualizarEstado("dbo.SP_VT_EditarInventarioOportunidades", valor);

            gwGrilla.EditIndex = -1;
            this.TraerGrilla(gwGrilla, "dbo.SP_VT_GestionOportunidades");
        }

        protected void gwGrilla_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gwGrilla.EditIndex = -1;
            this.TraerGrilla(gwGrilla, "dbo.SP_VT_GestionOportunidades");
        }

        protected void LinkButton3_Click1(object sender, EventArgs e)
        {
            Masivo.Visible = true;
        }
    }

       
}
