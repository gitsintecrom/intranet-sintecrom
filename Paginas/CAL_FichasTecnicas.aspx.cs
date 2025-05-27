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
    public partial class CAL_FichasTecnicas : System.Web.UI.Page
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

                    if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES") || group == ("DOMINIOW_VENTAS") || group == ("DOMINIOW_CALIDAD") || group == ("DOMINIOW_SUPPLYCHAIN") || group == "DOMINIOW_PRODUCCION")
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

      

        private void TraerGrilla(GridView unGrid, GridView dosGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;         
            

            try
            {
                unosParametros = new SqlParameter[13];
               
              
                unosParametros[0] = new SqlParameter("@Familia", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = txtFamilia.Text;

                unosParametros[1] = new SqlParameter("@Espesor", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = txtEspesor.Text;

                unosParametros[2] = new SqlParameter("@Aleacion", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = txtAleacion.Text;

                unosParametros[3] = new SqlParameter("@Temple", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = txtTemple.Text;

                unosParametros[4] = new SqlParameter("@Terminacion", System.Data.SqlDbType.VarChar);
                unosParametros[4].Value = txtTerminacion.Text;

                unosParametros[5] = new SqlParameter("@Recubrimiento", System.Data.SqlDbType.VarChar);
                unosParametros[5].Value = txtRecubrimiento.Text;

                unosParametros[6] = new SqlParameter("@Forma", System.Data.SqlDbType.VarChar);
                unosParametros[6].Value = txtForma.Text;

                unosParametros[7] = new SqlParameter("@Estado", System.Data.SqlDbType.VarChar);
                unosParametros[7].Value = DropDownList1.SelectedValue;

                unosParametros[8] = new SqlParameter("@Buje", System.Data.SqlDbType.VarChar);
                unosParametros[8].Value = txtBuje.Text;

                unosParametros[9] = new SqlParameter("@DiametroInterno", System.Data.SqlDbType.VarChar);
                unosParametros[9].Value = txtDiametroInterno.Text;

                unosParametros[10] = new SqlParameter("@Empalme", System.Data.SqlDbType.VarChar);
                unosParametros[10].Value = txtEmpalme.Text;

                unosParametros[11] = new SqlParameter("@TipoEmbalaje", System.Data.SqlDbType.VarChar);
                unosParametros[11].Value = DropDownList2.SelectedValue;

                unosParametros[12] = new SqlParameter("@CodigoEmbalaje", System.Data.SqlDbType.VarChar);
                unosParametros[12].Value = txtCodigoEmbalaje.Text;
               

               
                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);
                

                unGrid.DataSource = unDS;

                unGrid.DataBind();

                dosGrid.DataSource = unDS;

                dosGrid.DataBind();
              

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


                //e.Row.Attributes["onClick"] = ClientScript.GetPostBackClientHyperlink(this.gwGrilla, "Select$" + e.Row.RowIndex);
                //e.Row.ToolTip = "Haga Click para Seleccionar la línea.";

            }
           
        }

        protected void ButtonVer_Click(object sender, EventArgs e)
        {
            
        }

     

        protected void gwGrilla_RowDataBound1(object sender, GridViewRowEventArgs e)
        {
            //if (e.Row.RowType == DataControlRowType.DataRow)
            //{

            //    if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Kilos").ToString()))
            //    {
            //        dKilos += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Kilos"));
            //    }               
               
            //    e.Row.Attributes.Add("onMouseOver", "this.style.background='#f2d9d9';this.style.cursor='pointer'");

            //    e.Row.Attributes.Add("onMouseOut", "this.style.background='#ffffff'");


            //    //e.Row.Attributes["onClick"] = ClientScript.GetPostBackClientHyperlink(this.gwGrilla, "Select$" + e.Row.RowIndex);
            //    //e.Row.ToolTip = "Haga Click para Seleccionar la línea.";

            //}
            //if (e.Row.RowType == DataControlRowType.Footer)
            //{
            //    //e.Row.BackColor = Color.DarkRed;
            //    e.Row.ForeColor = Color.White;
            //    e.Row.Cells[2].Text = "Stock:";
            //    e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Center;
            //    e.Row.Cells[3].Text = dKilos.ToString("0");
            //    lblTotal.Visible = true;
            //    lblInfo.Visible = true;
            //    lblTotal.Text = dKilos.ToString("0");

            //}
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            GridView1.Visible = true;
            StringBuilder sb = new StringBuilder();
            StringWriter sw = new StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            Page page = new Page();
            HtmlForm form = new HtmlForm();

            GridView1.EnableViewState = false;
            page.EnableEventValidation = false;
            page.DesignerInitialize();
            page.Controls.Add(form);
            form.Controls.Add(GridView1);
            page.RenderControl(htw);

            Page.Response.Clear();
            Page.Response.Buffer = true;
            Page.Response.ContentType = "application/vnd.ms-excel";

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= FichasTecnicas.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
            GridView1.Visible = false;

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            this.TraerGrilla(gwGrilla, GridView1, "dbo.SP_CAL_TraerFichaTecnica");
            LinkButton2.Visible = true;
        }
        
    }

       
}
