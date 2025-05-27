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
    public partial class VT_DetallePedidos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.TraerDetalle("dbo.SP_Traer_DetallePedidos");
            Chart1.Visible = true;
            Label1.Text = Session["NumeroPedido"].ToString();
        }

        private void TraerDetalle(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
           

            try
            {

               
                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@Pedido", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["NumeroPedido"].ToString();

                unosParametros[1] = new SqlParameter("@Item", System.Data.SqlDbType.Char);
                unosParametros[1].Value = Session["Item"].ToString();
                


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

       
       
           

        }

    
       
}


