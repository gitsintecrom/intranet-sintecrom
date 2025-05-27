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
    public partial class VT_GestionStockDisponibleVentas : System.Web.UI.Page
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

                    if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES") )
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
                    CargarComboDeposito();
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

                unosParametros[5] = new SqlParameter("@Deposito", System.Data.SqlDbType.VarChar);
                unosParametros[5].Value = ddDeposito.SelectedValue; 

               
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

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= Inventario.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            this.TraerGrilla(gwGrilla, "dbo.SP_VT_GestionInventarioDisponible");
            LinkButton2.Visible = true;
            LinkButton3.Visible = true;
            LinkButton4.Visible = true;
        }

        protected void gwGrilla_RowDataBound2(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {                

                Button bEstado = (Button)e.Row.FindControl("Button1");


                if (bEstado.Text == "Habilitado")
                {
                    bEstado.BackColor = System.Drawing.Color.Green;
                  
                }
                else
                {
                    bEstado.BackColor = System.Drawing.Color.FromArgb(255, 0, 0);
                }

                Button bEstado11 = (Button)e.Row.FindControl("Button11");


                if (bEstado11.Text == "Si")
                {
                    bEstado11.BackColor = System.Drawing.Color.Green;

                }
                else
                {
                    bEstado11.BackColor = System.Drawing.Color.FromArgb(255, 0, 0);
                    bEstado11.Enabled = false;
                }
                   

            }              
                    
        }

        private void ActualizarEstado(string nombreStored, string sLote, string sEstado)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@Lote_ID", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = sLote;

                unosParametros[1] = new SqlParameter("@Estado", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = sEstado;

                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreStored), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

        private void HabilitarTodo(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Estado", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = 'T';

                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreStored), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

        private void DeshabilitarTodo(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Estado", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = 'F';

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
            if (e.CommandName == "Estado")
            {
           
                string sloteID = (e.CommandArgument as string);
                
                Button bEstado =(Button)e.CommandSource;
                string sEstado = bEstado.Text;



                if (sEstado == "Habilitado")
                {
                   sEstado = "F";
                }
                else
                {
                    sEstado = "T";
                }

                this.ActualizarEstado("dbo.SP_VT_EditarInventarioDisponible", sloteID, sEstado);
                this.TraerGrilla(gwGrilla, "dbo.SP_VT_GestionInventarioDisponible");


            }
            if (e.CommandName == "Condicionado")
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

        private void CargarComboDeposito()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_VT_TraerComboDeposito"));

                ddDeposito.DataSource = unDS;
                ddDeposito.DataValueField = "Codigo";
                ddDeposito.DataTextField = "Descripcion";
                ddDeposito.DataBind();
                ddDeposito.Items.Insert(0, new ListItem("Seleccione...", ""));

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            //this.HabilitarTodo("dbo.SP_VT_EditarInventarioDisponibleMasivo");
            //this.TraerGrilla(gwGrilla, "dbo.SP_VT_GestionInventarioDisponible");
            
            foreach (GridViewRow row in gwGrilla.Rows)
            {
                string sloteID = this.gwGrilla.DataKeys[row.DataItemIndex].Values[0].ToString();
                this.ActualizarEstado("dbo.SP_VT_EditarInventarioDisponible", sloteID, "T");
            }
            this.TraerGrilla(gwGrilla, "dbo.SP_VT_GestionInventarioDisponible");
        }

        protected void LinkButton4_Click(object sender, EventArgs e)
        {
            
            //this.DeshabilitarTodo("dbo.SP_VT_EditarInventarioDisponibleMasivo");
            //this.TraerGrilla(gwGrilla, "dbo.SP_VT_GestionInventarioDisponible");
            foreach (GridViewRow row in gwGrilla.Rows)
            {
                string sloteID = this.gwGrilla.DataKeys[row.DataItemIndex].Values[0].ToString();
                this.ActualizarEstado("dbo.SP_VT_EditarInventarioDisponible", sloteID, "F");
            }
            this.TraerGrilla(gwGrilla, "dbo.SP_VT_GestionInventarioDisponible");
        }

        public void OnConfirm(object sender, EventArgs e)
        {
            string confirmValue = Request.Form["confirm_value"];
            if (confirmValue == "Yes")
            {
                this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('You clicked YES!')", true);
            }
            else
            {
                this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('You clicked NO!')", true);
            }
        }

        protected void LinkButton5_Click(object sender, EventArgs e)
        {
            Mensaje.Visible = false;
        }

      

    }

       
}
