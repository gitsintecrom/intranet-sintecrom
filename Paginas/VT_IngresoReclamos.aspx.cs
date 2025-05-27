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
using System.Net.Mail;



namespace SintecromNet.Paginas
{
    public partial class VT_IngresoReclamos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["Accede"] = "NO";
                Session["Cert"] = "";




                IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                foreach (IdentityReference i in irc)
                {
                    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                    if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_VENTAS" || group == "DOMINIOW_VENDEDORES")
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

                    CargarComboClientes();
                    TextBoxIni.Text = DateTime.Now.ToShortDateString();
                }
              
            }

        
        }
      

        protected void btnEjecutar_Click(object sender, EventArgs e)
        {

            if (DropDownList1.SelectedValue == "Otros")
            {
                this.InsertarDatos("dbo.SP_InsertarReclamos");
                EnviarEmail();

                LimpiarCampos();
                Response.Write("<script>window.confirm('El Reclamo ha Sido Ingresado Exitosamente');</script>");
            }
            else
            {
                int i = 0;

                ArrayList checkedItems = new ArrayList();

                foreach (GridViewRow row in this.gwGrilla.Rows)
                {
                    if (((CheckBox)row.FindControl("chkSelecciona")).Checked)
                    {
                        checkedItems.Add(
                            this.gwGrilla.DataKeys[row.RowIndex].Values[0] + "," +
                            this.gwGrilla.DataKeys[row.RowIndex].Values[1] + "," +
                            this.gwGrilla.DataKeys[row.RowIndex].Values[2] + "," +
                            this.gwGrilla.DataKeys[row.RowIndex].Values[3] + "," +
                            this.gwGrilla.DataKeys[row.RowIndex].Values[4]);
                        i++;
                    }
                }

                    if (checkedItems.Count == 0)
                    {
                        Response.Write("<script>window.confirm('Debe Seleccionar por lo menos un item del Remito');</script>");
                    }
                    else
                    {
                        this.InsertarDatos("dbo.SP_InsertarReclamos");
                        //Inserto Los items de Remitos Seleccionados

                        for (int f = 0; f < checkedItems.Count; f++)
                        {
                            string[] ItemsRemitos = checkedItems[f].ToString().Split(',');

                            string sRemito = (ItemsRemitos[0]);
                            string sSerieLote = (ItemsRemitos[1]);
                            int iKilos = Convert.ToInt32(ItemsRemitos[2]);
                            string sCodigo = (ItemsRemitos[4]);
                            string sDescri = (ItemsRemitos[5]);

                            this.InsertarItems("dbo.SP_InsertarItemsReclamos", sRemito, sSerieLote, iKilos, sCodigo, sDescri);

                        }
                       
                    }
                    EnviarEmail();
                    
                    LimpiarCampos();
                    Response.Write("<script>window.confirm('El Reclamo ha Sido Ingresado Exitosamente');</script>");

                    
            }
           
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            LimpiarCampos();
        }

        private void InsertarDatos(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlCommand cmd = new SqlCommand(nombreSP);

            try
            {
                unosParametros = new SqlParameter[10];

                unosParametros[0] = new SqlParameter("@Tipo", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = DropDownList1.SelectedValue;

                unosParametros[1] = new SqlParameter("@Fecha", System.Data.SqlDbType.DateTime);
                unosParametros[1].Value = TextBoxIni.Text;

                unosParametros[2] = new SqlParameter("@Cliente", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = ddClientes.SelectedItem.Text.ToString();
                                
                unosParametros[3] = new SqlParameter("@Contacto", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = txtContacto.Text.Trim();

                unosParametros[4] = new SqlParameter("@Email", System.Data.SqlDbType.VarChar);
                unosParametros[4].Value = txtEmail.Text.Trim();
                
                unosParametros[5] = new SqlParameter("@Motivo", System.Data.SqlDbType.VarChar);
                unosParametros[5].Value = txtMotivo.Text.Trim();

                unosParametros[6] = new SqlParameter("@Emite", System.Data.SqlDbType.VarChar);
                unosParametros[6].Value = txtEmite.Text.Trim();

                unosParametros[7] = new SqlParameter("@Observaciones", System.Data.SqlDbType.VarChar);
                unosParametros[7].Value = txtObservaciones.Text.Trim();

                unosParametros[8] = new SqlParameter("@ReclamoExterno", System.Data.SqlDbType.VarChar);
                unosParametros[8].Value = txtReclamoExterno.Text.Trim();

                unosParametros[9] = new SqlParameter("@id_new", System.Data.SqlDbType.Int);
                unosParametros[9].Direction = (ParameterDirection.Output); 
                

                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(cmd, unosParametros);
                //unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreSP), unosParametros);
                Session["id_new"] = Convert.ToInt32(cmd.Parameters["@id_new"].Value);
                //Session["id_new"] = Convert.ToInt32(unDS.Tables[0].Rows[0]["@id_new"]);

                
                
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

        private void InsertarItems(string nombreSP, string sRemito, string sSerie, int iKilos, string sCodigo, string sDescri)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlCommand cmd = new SqlCommand(nombreSP);

            try
            {
                unosParametros = new SqlParameter[6];

                unosParametros[0] = new SqlParameter("@NroRemito", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = sRemito;

                unosParametros[1] = new SqlParameter("@SerieLote", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = sSerie;

                unosParametros[2] = new SqlParameter("@Kilos", System.Data.SqlDbType.Int);
                unosParametros[2].Value = iKilos;

                unosParametros[3] = new SqlParameter("@Reclamo_ID", System.Data.SqlDbType.Int);
                unosParametros[3].Value = Convert.ToInt32(Session["id_new"]);

                unosParametros[4] = new SqlParameter("@CodigoP", System.Data.SqlDbType.VarChar);
                unosParametros[4].Value = sCodigo;

                unosParametros[5] = new SqlParameter("@DescripcionP", System.Data.SqlDbType.VarChar);
                unosParametros[5].Value = sDescri;

                                            

                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(cmd, unosParametros);
            



            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

        private void LimpiarCampos()
        {
            DropDownList1.SelectedValue = "Producto";
            TextBoxIni.Text = "";
            ddClientes.SelectedValue = "";
            txtContacto.Text = "";
            txtEmail.Text = "";
            
            txtRemito.Text = "";
           
            txtMotivo.Text = "";
           
            txtEmite.Text = "";
            txtObservaciones.Text = "";
            txtReclamoExterno.Text = "";
            Panel1.Visible = false;


        }

        private void CargarComboClientes()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_VT_TraerComboClientes"));

                ddClientes.DataSource = unDS;
                ddClientes.DataValueField = "Cliente_id";
                ddClientes.DataTextField = "Denominacion";
                ddClientes.DataBind();
                ddClientes.Items.Insert(0, new ListItem("Seleccione...", ""));

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Panel1.Visible = true;
            if (DropDownList1.SelectedValue == "Otros")
            {
                gwGrilla.Visible = false;
            }
            else
            {
                gwGrilla.Visible = true;
                this.TraerGrilla(gwGrilla, "SP_VT_TraerRemitoReclamos");

            }
        }

        private void TraerGrilla(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[2];


                unosParametros[0] = new SqlParameter("@NroRemito", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = txtRemito.Text;

                unosParametros[1] = new SqlParameter("@Cliente", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = ddClientes.SelectedValue;

               

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

        protected void gwGrilla_RowDataBound1(object sender, GridViewRowEventArgs e)
        {

        }

        private bool EnviarEmail()
        {

            MailMessage msg = new MailMessage();

            msg.To.Add("gbroide@sintecrom.com.ar, megonzalez@sintecrom.com.ar, ninsua@sintecrom.com.ar");

            msg.From = new MailAddress("mail.sistemas.sintecrom@gmail.com", "Reclamos Clientes", System.Text.Encoding.UTF8);

            msg.Subject = "Autorización Reclamo Clientes";

            msg.SubjectEncoding = System.Text.Encoding.UTF8;

            msg.Body = "Existe un Nuevo Reclamo Para Autorizar del Cliente: " + ddClientes.SelectedValue;

            msg.BodyEncoding = System.Text.Encoding.UTF8;

            msg.IsBodyHtml = false; //Si vas a enviar un correo con contenido html entonces cambia el valor a true
            //Aquí es donde se hace lo especial

            SmtpClient client = new SmtpClient();

            //client.Credentials = new System.Net.NetworkCredential("mail.sistemas.sintecrom@gmail.com", "Sinte1234");

            client.Port = 587;

            client.Host = "smtp.gmail.com";//Este es el smtp valido para Gmail

            client.EnableSsl = true; //Esto es para que vaya a través de SSL que es obligatorio con GMail

            client.UseDefaultCredentials = false;
            //client.Credentials = new System.Net.NetworkCredential("mail.sistemas.sintecrom@gmail.com", "Sinte.2023*");
            client.Credentials = new System.Net.NetworkCredential("mail.sistemas.sintecrom@gmail.com", "elvyffedyeximpwp");
            client.DeliveryMethod = SmtpDeliveryMethod.Network;

            try
            {
                client.Send(msg);

                return true;
            }

            catch (Exception)
            {
                return false;
            }

        }

       
       
    }

       
}
