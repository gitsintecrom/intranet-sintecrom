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
using System.Drawing;

namespace SintecromNet.Paginas
{
    public partial class SC_PendientesCredito : System.Web.UI.Page
    {        
            public decimal dTotalR;
            public decimal dTotal1;
            public decimal dTotal2;
            public decimal dTotal3;
            public decimal dTotal4;
            public decimal dTotal;
            public decimal dTotalA;

            public decimal dTotalR0;
            public decimal dTotal10;
            public decimal dTotal20;
            public decimal dTotal30;
            public decimal dTotal40;
            public decimal dTotal0;
            public decimal dTotalA0;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Accede"] = "NO";           
           

            IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
            foreach (IdentityReference i in irc)
            {
                string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_SUPPLYCHAIN")
                {

                    Session["Accede"] = "OK";


                }

            }
            if (Session["Accede"].ToString() == "NO")
            {
                Response.Redirect("Restringida.aspx");

            }

            this.TraerPendientesCredito("dbo.SP_I_TraerPendientesCredito");
            this.TraerPendientesCreditoGrilla("dbo.SP_TraerPendientesCredito");

            Label1.Text = "No En Remito Mes en Curso: " + (Convert.ToString(DateTime.Now.ToString("MMMM"))) + " " + DateTime.Now.Year.ToString();

            this.TraerPendientesCreditoER("dbo.SP_I_TraerPendientesCreditoEnRemito");
            this.TraerPendientesCreditoGrillaER("dbo.SP_TraerPendientesCreditoEnRemito");

            Label2.Text = "En Remito Mes en Curso: " + (Convert.ToString(DateTime.Now.ToString("MMMM"))) + " " + DateTime.Now.Year.ToString();
            
        }

     
      
        private void TraerPendientesCredito(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));              
          

                //gwPendientesComercial.DataSource = unDS;
                //gwPendientesComercial.DataBind();

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerPendientesCreditoER(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));


                //gwPendientesComercial.DataSource = unDS;
                //gwPendientesComercial.DataBind();

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerPendientesCreditoGrilla(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));


                gwPendientesCredito.DataSource = unDS;
                gwPendientesCredito.DataBind();

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerPendientesCreditoGrillaER(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));


                gwPendientesCredito0.DataSource = unDS;
                gwPendientesCredito0.DataBind();

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }


        protected void Button2_Click1(object sender, EventArgs e)
        {

        }

      

       

        protected void gwPendientesCredito_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Retraso").ToString()))
                {
                    dTotalR += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Retraso"));
                }

                if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Semana1").ToString()))
                {
                    dTotal1 += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Semana1"));
                }

                if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Semana2").ToString()))
                {
                    dTotal2 += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Semana2"));
                }

                if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Semana3").ToString()))
                {
                    dTotal3 += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Semana3"));
                }

                if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Semana4").ToString()))
                {
                    dTotal4 += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Semana4"));
                }

                if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Adelanto").ToString()))
                {
                    dTotalA += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Adelanto"));
                }

                if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Total").ToString()))
                {
                    dTotal += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Total"));
                }

            }
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                e.Row.BackColor = Color.DarkRed;
                e.Row.ForeColor = Color.White;
                e.Row.Cells[0].Text = "Totales:";
                e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[1].Text = dTotalR.ToString("0.00");
                e.Row.Cells[1].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[2].Text = dTotal1.ToString("0.00");
                e.Row.Cells[2].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[3].Text = dTotal2.ToString("0.00");
                e.Row.Cells[3].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[4].Text = dTotal3.ToString("0.00");
                e.Row.Cells[4].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[5].Text = dTotal4.ToString("0.00");
                e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[6].Text = dTotalA.ToString("0.00");
                e.Row.Cells[6].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[7].Text = dTotal.ToString("0.00");
                e.Row.Cells[7].HorizontalAlign = HorizontalAlign.Center;



            }  
        }

        protected void gwPendientesCredito0_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Retraso").ToString()))
                {
                    dTotalR0 += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Retraso"));
                }

                if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Semana1").ToString()))
                {
                    dTotal10 += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Semana1"));
                }

                if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Semana2").ToString()))
                {
                    dTotal20 += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Semana2"));
                }

                if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Semana3").ToString()))
                {
                    dTotal30 += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Semana3"));
                }

                if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Semana4").ToString()))
                {
                    dTotal40 += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Semana4"));
                }

                if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Adelanto").ToString()))
                {
                    dTotalA0 += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Adelanto"));
                }

                if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Total").ToString()))
                {
                    dTotal0 += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Total"));
                }

            }
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                e.Row.BackColor = Color.DarkRed;
                e.Row.ForeColor = Color.White;
                e.Row.Cells[0].Text = "Totales:";
                e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[1].Text = dTotalR0.ToString("0.00");
                e.Row.Cells[1].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[2].Text = dTotal10.ToString("0.00");
                e.Row.Cells[2].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[3].Text = dTotal20.ToString("0.00");
                e.Row.Cells[3].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[4].Text = dTotal30.ToString("0.00");
                e.Row.Cells[4].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[5].Text = dTotal40.ToString("0.00");
                e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[6].Text = dTotalA0.ToString("0.00");
                e.Row.Cells[6].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[7].Text = dTotal0.ToString("0.00");
                e.Row.Cells[7].HorizontalAlign = HorizontalAlign.Center;



            }  
        }
    }
}