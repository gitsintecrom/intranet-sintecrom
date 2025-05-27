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


namespace SintecromNet.Paginas
{
    public partial class VT_EstadoCarteraNoCumplido : System.Web.UI.Page
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

                    if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_VENTAS")
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

        private void TraerCartera(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
           

            try
            {

              
                unosParametros = new SqlParameter[4];

                unosParametros[0] = new SqlParameter("@Cliente", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = txtCliente.Text;

                unosParametros[1] = new SqlParameter("@Vendedor", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = txtVendedor.Text;

                unosParametros[2] = new SqlParameter("@Numero", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = txtNumeroPedido.Text;

                unosParametros[3] = new SqlParameter("@Estado", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = DropDownList1.SelectedValue;

               

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
      

        protected void Button2_Click1(object sender, EventArgs e)
        {

        }

     
       


        protected void btnExcel_Click(object sender, ImageClickEventArgs e)
        {
            string nombre = "EstadoCartera" + DateTime.Now.ToShortDateString();
            DataTable tabla = (DataTable)(Session["Tabla"]);

            Clases.Varias.ExportToSpreadsheet(tabla, nombre);
        }

        protected void ButtonVer_Click(object sender, EventArgs e)
        {
            gwNoCumplidos.Visible = true;
            ReportViewer1.Visible = false;
            this.TraerCartera(gwNoCumplidos, "dbo.SP_Traer_Pedidos_No_Cumplidos");

            if (gwNoCumplidos.Rows.Count > 0)
            {
                imgImprimir.Visible = true;


            }
            else
            {
                
                imgImprimir.Visible = false;


            }
        }

        protected void imgImprimir_Click(object sender, ImageClickEventArgs e)
        {
            gwNoCumplidos.Visible = false;
            imgImprimir.Visible = false;
            DataTable tabla = (DataTable)(Session["Tabla"]);

            ReportViewer1.Visible = true;
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportDataSource datasource = new ReportDataSource("DataSet2", tabla);

            ReportViewer1.LocalReport.DataSources.Add(datasource);
            ReportViewer1.LocalReport.Refresh();
            
           
        }

        protected void gwNoCumplidos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
            
                int index = Convert.ToInt32(e.CommandArgument);

            
                Session["NumeroPedido"] = gwNoCumplidos.Rows[index].Cells[3].ToString();

            }
        }

        protected void gwNoCumplidos_RowDataBound(object sender, GridViewRowEventArgs e)
        {
             if (e.Row.RowType == DataControlRowType.DataRow)
             {
                 e.Row.Attributes.Add("onMouseOver", "this.style.background='#f2d9d9';this.style.cursor='pointer'");

                 e.Row.Attributes.Add("onMouseOut", "this.style.background='#ffffff'");


                 e.Row.Attributes["onClick"] = ClientScript.GetPostBackClientHyperlink(this.gwNoCumplidos, "Select$" + e.Row.RowIndex);
                 e.Row.ToolTip = "Haga Click para Seleccionar la línea.";
                




             }

        }

        protected void gwNoCumplidos_SelectedIndexChanged(object sender, EventArgs e)
        {
            
            GridViewRow row = gwNoCumplidos.SelectedRow;

            Session["NumeroPedido"] = row.Cells[4].Text;
            Session["Item"] = row.Cells[5].Text;
            Session["Clon"] = row.Cells[6].Text;
            
           
            HiddenFieldError_ModalPopupExtender.Show();
            this.TraerDetalle("dbo.SP_Traer_DetallePedidos");
            this.LlenoTemporalEnFabricacion("dbo.SP_I_OperacionesEnFabricacion");
            this.TraerEnFabricacion("dbo.SP_Traer_EnFabricacion");
            
            Label2.Text = Session["NumeroPedido"].ToString();


        }

        private void TraerDetalle(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;


            try
            {


                unosParametros = new SqlParameter[3];

                unosParametros[0] = new SqlParameter("@Pedido", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["NumeroPedido"].ToString();

                unosParametros[1] = new SqlParameter("@Item", System.Data.SqlDbType.Char);
                unosParametros[1].Value = Session["Item"].ToString();

                unosParametros[2] = new SqlParameter("@Clon", System.Data.SqlDbType.Char);
                unosParametros[2].Value = Session["Clon"].ToString();



                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);




                //Cargo el Chart con la lista de los usuarios con rol
                Chart1.DataSource = unDS;

                Chart1.Series["Series1"].XValueMember = "Pedido_Neto";
                Chart1.Series["Series1"].YValueMembers = "Pedido_Neto";

                Chart1.Series["Series2"].XValueMember = "Pedido_Neto";
                Chart1.Series["Series2"].YValueMembers = "Programado";

                Chart1.Series["Series3"].XValueMember = "Pedido_Neto";
                Chart1.Series["Series3"].YValueMembers = "Fabricado";

                Chart1.Series["Series4"].XValueMember = "Pedido_Neto";
                Chart1.Series["Series4"].YValueMembers = "Remitido";

                Chart1.Series["Series5"].XValueMember = "Pedido_Neto";
                Chart1.Series["Series5"].YValueMembers = "Entregado";

                gwPedidoSeleccionado.DataSource = unDS;
                gwPedidoSeleccionado.DataBind();

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void LlenoTemporalEnFabricacion(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
            SqlParameter[] unosParametros = null;


            try
            {


                unosParametros = new SqlParameter[3];

                unosParametros[0] = new SqlParameter("@Pedido", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["NumeroPedido"].ToString();               

                unosParametros[1] = new SqlParameter("@Clon", System.Data.SqlDbType.Char);
                unosParametros[1].Value = Session["Clon"].ToString();

                unosParametros[2] = new SqlParameter("@Item", System.Data.SqlDbType.Char);
                unosParametros[2].Value = Session["Item"].ToString();


                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreStored), unosParametros);

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerEnFabricacion(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));


                gwEnFabricacion.DataSource = unDS;
                gwEnFabricacion.DataBind();

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
     

    

    }

       
}
