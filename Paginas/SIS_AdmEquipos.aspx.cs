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
    public partial class SIS_AdmEquipos : System.Web.UI.Page
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
                        btnBuscar.Focus();


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
            LimpioCampos();
            lblMsg.Visible = false;
            gwGrilla.Visible = true;

            this.TraerEquipos(gwGrilla, "dbo.SP_I_TraerEquipos");
            imgEditar.Visible = true;
            imgBorrar.Visible = true;
            LinkButton2.Visible = true;
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Session["Accion"] = "A";
            ManejoCampos();
        }

        protected void gwIncidentes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Seleccionar")
            {
                int fila = (Convert.ToInt32(e.CommandArgument));
                Session["Otros"] = this.gwGrilla.DataKeys[fila].Values[0].ToString();
                Session["ID"] = this.gwGrilla.DataKeys[fila].Values[1].ToString();
                Session["Serie"] = this.gwGrilla.DataKeys[fila].Values[2].ToString();
                Session["Identificador"] = this.gwGrilla.DataKeys[fila].Values[3].ToString();
                Session["Tipo"] = this.gwGrilla.DataKeys[fila].Values[4].ToString();


            }
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

        protected void imgEditar_Click(object sender, ImageClickEventArgs e)
        {
            Session["Accion"] = "M";
            int i = 0;

            foreach (GridViewRow row in this.gwGrilla.Rows)
            {


                if (((CheckBox)row.FindControl("CheckBox2")).Checked)
                {
                    
                    Session["Address"] = this.gwGrilla.Rows[row.RowIndex].Cells[1].Text.ToString();
                    Session["Equipo"] = this.gwGrilla.Rows[row.RowIndex].Cells[2].Text.ToString();
                    Session["IP"] = this.gwGrilla.Rows[row.RowIndex].Cells[3].Text.ToString();
                    Session["Usuario"] = this.gwGrilla.Rows[row.RowIndex].Cells[4].Text.ToString();
                    Session["Sector"] = this.gwGrilla.Rows[row.RowIndex].Cells[5].Text.ToString();
                    Session["Tipo"] = this.gwGrilla.DataKeys[row.RowIndex].Values[4].ToString();

                    //
                    Session["Otros"] = this.gwGrilla.DataKeys[row.RowIndex].Values[0].ToString();
                    Session["ID"] = this.gwGrilla.DataKeys[row.RowIndex].Values[1].ToString();
                    Session["Serie"] = this.gwGrilla.DataKeys[row.RowIndex].Values[2].ToString();
                    Session["Identificador"] = this.gwGrilla.DataKeys[row.RowIndex].Values[3].ToString();
                   


                    i++;
                }
            }



            if (i != 1)
            {
                lblMsg.Visible = true;
                lblMsg.CssClass = "alert alert-danger";
                lblMsg.Text = "Debe Seleccionar un solo Equipo";
                return;
            }
            else
            {
                lblMsg.Visible = false;
                ManejoCampos();
               

                txtAddress.Text = Session["Address"].ToString();
                txtEquipoi.Text = Session["Equipo"].ToString();
                txtIP.Text = Session["IP"].ToString();
                txtUsuarioi.Text = Session["Usuario"].ToString();
                txtSector.Text = Session["Sector"].ToString();
                DropDownList1.SelectedValue = Session["Tipo"].ToString();
                txtOtros.Text = Session["Otros"].ToString();
                txtSerie.Text = Session["Serie"].ToString();
                txtIdentificador.Text = Session["Identificador"].ToString();
              
            }
           
        }

        protected void imgBorrar_Click(object sender, ImageClickEventArgs e)
        {
            Session["Accion"] = "B";

            int i = 0;

            foreach (GridViewRow row in this.gwGrilla.Rows)
            {

                if (((CheckBox)row.FindControl("CheckBox2")).Checked)
                {
                    Session["ID"] = this.gwGrilla.DataKeys[row.RowIndex].Values[1].ToString();
                    i++;
                }
            }



            if (i != 1)
            {
                lblMsg.Visible = true;
                lblMsg.CssClass = "alert alert-danger";
                lblMsg.Text = "Debe Seleccionar un solo Equipo";
                return;
            }
            else
            {
                lblMsg.Visible = false;
                Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("Sistemas");

                try
                {
                    unAcceso.AbrirConexion();
                    unAcceso.EjecutarSentencia_NonQuery("exec dbo.SP_EliminarEquipos " + Convert.ToInt32(Session["ID"]));

                    lblMsg.Visible = true;
                    lblMsg.CssClass = "alert alert-success";
                    lblMsg.Text = "El Equipo se ha Eliminado Correctamente";
                    //LimpioCampos();
                    this.TraerEquipos(gwGrilla, "dbo.SP_I_TraerEquipos");
                }

                finally
                {
                    unAcceso.CerrarConexion();
                }

            }
        }



        private void LimpioCampos()
        {
            Session["Accion"] = "K";
            imgEditar.Enabled = true;
            imgBorrar.Enabled = true;
            btnBuscar.Visible = true;
            Label4.Visible = false;
            Label5.Visible = false;
            Label6.Visible = false;
            Label7.Visible = false;
            Label8.Visible = false;
            Label9.Visible = false;
            Label10.Visible = false;
            Label12.Visible = false;
            Label13.Visible = false;
            txtAddress.Visible = false;
            txtEquipoi.Visible = false;
            txtIP.Visible = false;
            txtSector.Visible = false;
            txtUsuarioi.Visible = false;
            txtOtros.Visible = false;
            txtSerie.Visible = false;
            txtIdentificador.Visible = false;
            DropDownList1.Visible = false;
            btnAceptar.Visible = false;
            btnCancelar.Visible = false;
            imgEditar.Visible = false;
            imgBorrar.Visible = false;
            gwGrilla.Visible = false;
            Session["Address"] = "";
            Session["Equipo"] = "";
            Session["IP"] = "";
            Session["Usuario"] = "";
            Session["Sector"] = "";
            Session["Interno"] = "";
            Session["Otros"] = "";
            Session["ID"] = "";
            Session["Tipo"] = "";
            Session["Identificador"] = "";
            Session["Serie"] = "";

        }

        private void ManejoCampos()
        {
            if (Session["Accion"].ToString() == "A")
            {
                
                gwGrilla.Visible = false;
                LinkButton2.Visible = false;
                Label4.Visible = true;
                Label5.Visible = true;
                Label6.Visible = true;
                Label7.Visible = true;
                Label8.Visible = true;
                Label9.Visible = true;
                Label10.Visible = true;
                Label12.Visible = true;
                Label13.Visible = true;
                txtAddress.Visible = true;
                txtEquipoi.Visible = true;
                txtIP.Visible = true;
                txtSector.Visible = true;
                txtUsuarioi.Visible = true;
                DropDownList1.Visible = true;
                txtOtros.Visible = true;
                txtSerie.Visible = true;
                txtIdentificador.Visible = true;
                btnAceptar.Visible = true;
                btnCancelar.Visible = true;
                txtAddress.Focus();
            }
            else
            {
                if (Session["Accion"].ToString() == "M")
                {
                    
                    gwGrilla.Visible = false;
                    LinkButton2.Visible = false;
                    Label4.Visible = true;
                    Label5.Visible = true;
                    Label6.Visible = true;
                    Label7.Visible = true;
                    Label8.Visible = true;
                    Label9.Visible = true;
                    Label10.Visible = true;
                    Label12.Visible = true;
                    Label13.Visible = true;
                    txtAddress.Visible = true;
                    txtEquipoi.Visible = true;
                    txtIP.Visible = true;
                    txtSector.Visible = true;
                    txtSerie.Visible = true;
                    txtIdentificador.Visible = true;
                    txtUsuarioi.Visible = true;
                    DropDownList1.Visible = true;
                    txtOtros.Visible = true;
                    btnAceptar.Visible = true;
                    btnCancelar.Visible = true;
                    imgBorrar.Visible = false;
                    imgEditar.Visible = false;                   
                }
                else
                {
                    LimpioCampos();
                }
            }

        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            LimpioCampos();
        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
             
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("Sistemas");
            

            try
            {
                unAcceso.AbrirConexion();

                if (Session["Accion"].ToString() == "A")
                {
                    unAcceso.EjecutarSentencia_NonQuery("exec dbo.SP_InsertarEquipos '" + txtAddress.Text.Trim() +
                                                                                                "','" + txtUsuarioi.Text.Trim() +
                                                                                    "','" + txtEquipoi.Text.Trim() +
                                                                                    "','" + txtIP.Text.Trim() +
                                                                                    "','" + txtSector.Text.Trim() +
                                                                                    "','" + DropDownList1.SelectedValue +
                                                                                "','" + txtOtros.Text.Trim() + 
                                                                                "','" + txtSerie.Text.Trim() +
                                                                                    "','" + txtIdentificador.Text.Trim() + "'");
                    lblMsg.Visible = true;
                    lblMsg.CssClass = "alert alert-success";
                    lblMsg.Text = "El Equipo fue Ingresado Correctamente";
                    LimpioCampos(); 
                }
                else
                {
                    int iID = Convert.ToInt32(Session["ID"]);
                    if (Session["Accion"].ToString() == "M")
                    {
                        unAcceso.EjecutarSentencia_NonQuery("exec dbo.SP_EditarEquipos '" + txtAddress.Text.Trim() +
                                                                                                "','" + txtUsuarioi.Text.Trim() +
                                                                                    "','" + txtEquipoi.Text.Trim() +
                                                                                    "','" + txtIP.Text.Trim() +
                                                                                    "','" + txtSector.Text.Trim() +
                                                                                    "','" + DropDownList1.SelectedValue +
                                                                                    "','" + txtOtros.Text.Trim() +
                                                                                    "','" + txtSerie.Text.Trim() +
                                                                                    "','" + txtIdentificador.Text.Trim() +
                                                                                "'," + iID );
                        lblMsg.Visible = true;
                        lblMsg.CssClass = "alert alert-success";
                        lblMsg.Text = "El Equipo fue Modificado Correctamente";
                        LimpioCampos();
                    }
                    
                }
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

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= Equipos.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
        }

       

        
        
    }
}