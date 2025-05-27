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
    public partial class COM_GestionIPC : System.Web.UI.Page
    {
        DataTable dt = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
            foreach (IdentityReference i in irc)
            {
                string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES") || group == ("DOMINIOW_COMPRAS"))
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

                this.TraerGrilla(gwGrilla, "SP_COM_TraerIPC");


            }
        
        }
      

        protected void btnEjecutar_Click(object sender, EventArgs e)
        {
            if (Session["Accion"].ToString() == "A")
            {
                this.InsertarDatos("dbo.SP_COM_InsertarIPC");
                Response.Write("<script>window.confirm('El Indice ha Sido Ingresado Exitosamente');</script>");
                LimpiarCampos();


                divGrilla.Visible = true;
                this.TraerGrilla(gwGrilla, "SP_COM_TraerIPC");
                this.TraerInsumos("SP_COM_TraerInsumosValorizar");


            }

            else
            {
                if (Session["Accion"].ToString() == "M")
                {
                    this.EditarInterno("dbo.SP_COM_EditarIPC");
                    LimpiarCampos();
                    divGrilla.Visible = true;
                    this.TraerGrilla(gwGrilla, "SP_COM_TraerIPC");
                    this.TraerInsumos("SP_COM_TraerInsumosValorizar");
                    Response.Write("<script>window.confirm('El Indice ha Sido Modificado Exitosamente');</script>");

                }

            }
           
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            LimpiarCampos();
            divGrilla.Visible = true;
            this.TraerGrilla(gwGrilla, "SP_COM_TraerIPC");
        }
        private void TraerInsumos(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            


            try
            {
                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));


                for (int i = 0; i < unDS.Tables[0].Rows.Count; i++)
                {
                    decimal dipc = 0;
                    decimal valorIPC = 0;
                    string codigo = unDS.Tables[0].Rows[i]["Codigo"].ToString();
                    int id = Convert.ToInt32(unDS.Tables[0].Rows[i]["ID"]);
                    decimal valor = Convert.ToDecimal(unDS.Tables[0].Rows[i]["Valor"]);
                    DateTime fechi = Convert.ToDateTime(unDS.Tables[0].Rows[i]["Fech_Ulti_Ingr"]);
                    for (int u = 0; u < dt.Rows.Count; u++)                    
                    {
                        DateTime ff = Convert.ToDateTime(dt.Rows[u]["Fecha"]);
                        if (fechi < ff)
                        {
                            decimal dindice = Convert.ToDecimal(dt.Rows[u]["Indice"]);
                            dipc = dipc + dindice;
                        }                        
                    }
                    if(dipc > 0)
                    {
                        valorIPC = valor + (valor * dipc / 100);
                        this.EditarInsumo("dbo.SP_PROD_EditarValorInsumos", id, valorIPC);
                    }
                                       

                }

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
            //SqlParameter[] unosParametros = null;

            try
            {


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));


                unGrid.DataSource = unDS;
                dt = unDS.Tables[0].Copy();


                unGrid.DataBind();


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
                unosParametros = new SqlParameter[3];

                
                unosParametros[0] = new SqlParameter("@Nombre", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = txtNombre.Text.Trim();
                                
                unosParametros[1] = new SqlParameter("@Indice", System.Data.SqlDbType.Decimal);
                unosParametros[1].Value = txtIndice.Text.Replace(".", ","); 

                unosParametros[2] = new SqlParameter("@Mes", System.Data.SqlDbType.DateTime);
                unosParametros[2].Value = txtMes.Text;
                

                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

        private void EditarInterno(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[4];

                unosParametros[0] = new SqlParameter("@ID", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt32(Session["ID"]);

                unosParametros[1] = new SqlParameter("@Nombre", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = txtNombre.Text.Trim();

                unosParametros[2] = new SqlParameter("@Indice", System.Data.SqlDbType.Decimal);
                unosParametros[2].Value = txtIndice.Text.Replace(".", ",");

                unosParametros[3] = new SqlParameter("@Fecha", System.Data.SqlDbType.DateTime);
                unosParametros[3].Value = txtMes.Text;

                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);


            }
            finally
            {
                unAcceso.CerrarConexion();

            }

        }

        private void EditarInsumo(string nombreSP, int id, decimal valorIPC)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@ID", System.Data.SqlDbType.Int);
                unosParametros[0].Value = id;               

                unosParametros[1] = new SqlParameter("@Valor", System.Data.SqlDbType.Decimal);
                unosParametros[1].Value = valorIPC;             


                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);


            }
            finally
            {
                unAcceso.CerrarConexion();

            }

        }

        private void EliminarIPC(string nombreSP)
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
            txtNombre.Text = "";
            txtIndice.Text = "0";
            //txtMes.Text = "";
            Panel1.Visible = false;
           

        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Session["Accion"] = "A";
            Panel1.Visible = true;
            divGrilla.Visible = false;
        }

        protected void btnExcel_Click(object sender, ImageClickEventArgs e)
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

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= ListadoIPC.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();

        }

        protected void gwGrilla_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Editar")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                Panel1.Visible = true;
                divGrilla.Visible = false;
                Session["ID"] = this.gwGrilla.DataKeys[index].Values[0].ToString();
                Session["Accion"] = "M";
                txtNombre.Text = this.gwGrilla.DataKeys[index].Values[1].ToString();
                txtIndice.Text = this.gwGrilla.DataKeys[index].Values[2].ToString();
                txtMes.Text = this.gwGrilla.DataKeys[index].Values[3].ToString();




                //this.TraerIndice("dbo.SP_COM_TraerIPCID");


            }

            if (e.CommandName == "Eliminar")
            {


                int index = Convert.ToInt32(e.CommandArgument);
                //Panel1.Visible = true;
                Session["ID"] = this.gwGrilla.DataKeys[index].Values[0].ToString();
                Session["Accion"] = "B";
                this.EliminarIPC("dbo.SP_COM_EliminarIPC");
                //Panel1.Visible = false;
                this.TraerGrilla(gwGrilla, "SP_COM_TraerIPC");




            }
        }


       
    }

       
}
