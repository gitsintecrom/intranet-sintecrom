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




namespace SintecromNet.Paginas
{
    public partial class SRP_AnulacionOperaciones : System.Web.UI.Page
    {
        

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["Accede"] = "NO";
                Session["Accion"] = "";
                Session["Planta"] = "";


                IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                foreach (IdentityReference i in irc)
                {
                    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                    if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES") || group == "DOMINIOW_SUPPLYCHAIN")
                    {
                        Session["Accede"] = "OK";
                    }

                }
                if (Session["Accede"].ToString() == "NO")
                {
                    Response.Redirect("Restringida.aspx");
                }
               
            }
        
        }

      

        private void TraerGrilla(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("RegistracionNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;         
            

            try
            {
                unosParametros = new SqlParameter[4];               

                unosParametros[0] = new SqlParameter("@NumeroBatch", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = txtBBatch.Text;

                unosParametros[1] = new SqlParameter("@SL", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = txtBSerie.Text;                
               
                unosParametros[2] = new SqlParameter("@Maquina", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = DropDownList2.SelectedValue;               

                unosParametros[3] = new SqlParameter("@Operacion", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = txtBMatching.Text;
                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);
                

                unGrid.DataSource = unDS;

                unGrid.DataBind();
                DataTable dt = unDS.Tables[0].Copy();


                Session["Tabla"] = dt;

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void InsertarDatos(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("RegistracionNet");
            string sUsuario = Session["Usr"].ToString();
            sUsuario = Clases.Varias.RemoveSpecialCharacters(sUsuario);
            sUsuario = sUsuario.Replace("DOMINIO", "");


            try
            {
                unosParametros = new SqlParameter[7];

                unosParametros[0] = new SqlParameter("@Operacion_ID", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["Operacion_ID"].ToString().Trim();

                unosParametros[1] = new SqlParameter("@Maquina", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = Session["Maquina"].ToString().Trim();

                unosParametros[2] = new SqlParameter("@NroBatch", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = Session["NroBatch"].ToString().Trim();

                unosParametros[3] = new SqlParameter("@Serie_Lote", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = Session["SerieLote"].ToString().Trim();

                unosParametros[4] = new SqlParameter("@Operacion", System.Data.SqlDbType.VarChar);
                unosParametros[4].Value = Session["Operacion"].ToString().Trim();              

                unosParametros[5] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[5].Value = sUsuario.Trim();

                unosParametros[6] = new SqlParameter("@Motivo", System.Data.SqlDbType.VarChar);
                unosParametros[6].Value = Clases.Varias.RemoveSpecialCharacters(txtMotivo.Text);



                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

        private void ModificarDatos(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("RegistracionNet");          


            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Operacion_ID", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["Operacion_ID"].ToString().Trim();
               

                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

        private void ValidarBatch(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("RegistracionNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;



            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Nro_Batch", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["NroBatch"].ToString().Trim();

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);


                if (unDS.Tables[0].Rows.Count == 0 && Convert.ToInt32(Session["NroBatch"]) != 7042) //unDS
                {
                    this.CerrarBatch("dbo.SP_REG_CambiarFlagFabricado");
                }



            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void CerrarBatch(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");


            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Nro_Batch", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["NroBatch"].ToString().Trim();


                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

     

        protected void gwGrilla_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {

                int index = Convert.ToInt32(e.CommandArgument);


                Session["Operacion_ID"] = this.gwGrilla.DataKeys[index].Values[0].ToString();
                Session["Operacion"] = this.gwGrilla.DataKeys[index].Values[1].ToString();
                Session["Maquina"] = this.gwGrilla.DataKeys[index].Values[2].ToString();
                Session["NroBatch"] = this.gwGrilla.DataKeys[index].Values[3].ToString();
                Session["SerieLote"] = this.gwGrilla.DataKeys[index].Values[4].ToString();

            }
        }

        protected void gwGrilla_SelectedIndexChanged(object sender, EventArgs e)
        {      
            GridViewRow row = gwGrilla.SelectedRow;
            HiddenFieldError_ModalPopupExtender.Show();
            
            //Panel2.Visible = true;
            txtOperacion.Text = Session["Operacion"].ToString();
            txtMotivo.Focus();
           
            gwGrilla.Visible = false;
        }

        protected void gwGrilla_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                                
                e.Row.Attributes.Add("onMouseOver", "this.style.background='#f2d9d9';this.style.cursor='pointer'");

                e.Row.Attributes.Add("onMouseOut", "this.style.background='#ffffff'");


                e.Row.Attributes["onClick"] = ClientScript.GetPostBackClientHyperlink(this.gwGrilla, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Haga Click para Seleccionar la línea.";

            }
           
        }

        protected void ButtonVer_Click(object sender, EventArgs e)
        {
            this.TraerGrilla(gwGrilla, "dbo.SP_I_TraerOperacionesPorMaquina");
        
        }

        protected void Button2_Click1(object sender, EventArgs e)
        {
           
            this.ModificarDatos("dbo.SP_I_AnularOperacion");
            this.ValidarBatch("dbo.SP_TraerOperacionesPendientesBatch");
            this.InsertarDatos("dbo.SP_I_InsertarAnulacionOperacion");
            gwGrilla.Visible = true;
            this.TraerGrilla(gwGrilla, "dbo.SP_I_TraerOperacionesPorMaquina");
            Panel2.Visible = false;
        }


       

      
       

       

      
       
       


           

      
      

       
     

    }

       
}
