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
    public partial class DIR_Equipamiento : System.Web.UI.Page
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

                    if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_GERENTES")
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
                    Session["Accion"] = "K";
                    LinkButton2.Visible = false;
                    //this.CargarAsignados();
                }
            }
        }


       


      

        protected void btnBuscar_Click(object sender, EventArgs e)
        {

            //string name = Request.Form["Name1"];
            lblMsg.Visible = false;
            gwGrilla.Visible = true;

            this.TraerEquipos(gwGrilla, "dbo.SP_I_TraerEquipos");
          
            LinkButton2.Visible = true;
        }

      
       
       
   

        protected void gwIncidentes_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //if (e.Row.Cells[5].Text == "Abierto")
            //{
            //    e.Row.ControlStyle.BackColor = System.Drawing.Color.Red;
            //    e.Row.ControlStyle.ForeColor = System.Drawing.Color.White;
            //}
            //else
            //{
            //    if (e.Row.Cells[5].Text == "Asignado")
            //    {
            //        e.Row.ControlStyle.BackColor = System.Drawing.Color.Yellow;
            //        e.Row.ControlStyle.ForeColor = System.Drawing.Color.Black;
            //    }
            //    if (e.Row.Cells[5].Text == "Cerrado")
            //    {
            //        e.Row.ControlStyle.BackColor = System.Drawing.Color.Green;
            //        e.Row.ControlStyle.ForeColor = System.Drawing.Color.White;

            //    }
            //    if (e.Row.Cells[5].Text == "Estado")
            //    {
            //        //Es Cabecera no hago nada

            //    }
            //}
        }

        private void TraerEquipos(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("Sistemas");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;

            try
            {
                   
                unosParametros = new SqlParameter[4];

                unosParametros[0] = new SqlParameter("@Adress", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = txtNetAddress.Text.Trim();

                unosParametros[1] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = txtUsuario.Text.Trim();

                unosParametros[2] = new SqlParameter("@Host", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = txtEquipo.Text.Trim();

                unosParametros[3] = new SqlParameter("@Tipo", System.Data.SqlDbType.Int);
                unosParametros[3].Value = DropDownList2.SelectedValue;

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

      

       

        protected void gwIncidentes_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gwGrilla.PageIndex = e.NewPageIndex;
            this.TraerEquipos(gwGrilla, "dbo.SP_I_TraerEquipos");

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

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= Equipos.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
        }

       

        
        
    }
}