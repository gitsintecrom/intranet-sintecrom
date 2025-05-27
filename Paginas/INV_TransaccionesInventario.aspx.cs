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
    public partial class INV_TransaccionesInventario : System.Web.UI.Page
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

                    if (group == "DOMINIOW_SISTEMAS" ||  group == "DOMINIOW_GERENTES" || group == ("DOMINIOW_INVENTARIO"))
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
                    this.TraerGrilla(gwGrilla, "dbo.SP_INV_TraerTransaccionesInventario");
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


                unosParametros[0] = new SqlParameter("@Estado", System.Data.SqlDbType.Int);
                unosParametros[0].Value = DropDownList1.SelectedValue;

                unosParametros[1] = new SqlParameter("@FechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = TextBoxIni.Text;

                unosParametros[2] = new SqlParameter("@FechaHasta", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = TextBoxFin.Text;

                unosParametros[3] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = txtUsuario.Text;
               
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

        private void TraerGrillaDetalle(GridView unGrid, string nombreStored,int iNumeroMatching)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[1];


                unosParametros[0] = new SqlParameter("@NroMatching", System.Data.SqlDbType.Int);
                unosParametros[0].Value = iNumeroMatching;




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

      
      


        protected void gwGrilla_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Detalle")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                Panel1.Visible = true;
                Panel2.Visible = false;
                
                lblDetalle1.Text = this.gwGrilla.DataKeys[index].Values[0].ToString();
                Label2.Text = this.gwGrilla.DataKeys[index].Values[1].ToString();
                txtObservaciones.Text = this.gwGrilla.DataKeys[index].Values[4].ToString();
              
                Label1.Text = this.gwGrilla.DataKeys[index].Values[2].ToString();
                Session["Tipo"] = this.gwGrilla.DataKeys[index].Values[3].ToString();
                Session["ID"] = Convert.ToInt32(this.gwGrilla.DataKeys[index].Values[5]);  
   
            }
           
        }

       

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Panel1.Visible = false;
            Panel2.Visible = true;
        }

      

        protected void ButtonVer_Click(object sender, EventArgs e)
        {
            Panel2.Visible = true;
            this.TraerGrilla(gwGrilla, "dbo.SP_INV_TraerTransaccionesInventario");

        }
      

    }

       
}
