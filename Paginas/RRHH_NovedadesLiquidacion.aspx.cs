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
using System.Runtime.InteropServices;
using Excel = Microsoft.Office.Interop.Excel;
using System.Text.RegularExpressions;
using DocumentFormat.OpenXml.Packaging;


namespace SintecromNet.Paginas
{
    public partial class RRHH_NovedadesLiquidacion : System.Web.UI.Page
    {
       
          
           
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["Accede"] = "NO";
                Session["Accion"] = "";
                //Session["Tabla"] = "";
              

                IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                foreach (IdentityReference i in irc)
                {
                    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                    if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_RRHH"))
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

        private void getExcelFile(string sArchivo)
        {
            try
            {
                  //Create COM Objects. Create a COM object for everything that is referenced
            Excel.Application xlApp = new Excel.Application();
            Excel.Workbook xlWorkbook = xlApp.Workbooks.Open(sArchivo);
            Excel._Worksheet xlWorksheet = xlWorkbook.Sheets[1];
            Excel.Range xlRange = xlWorksheet.UsedRange;

            //Creo DataTable para ir guardando la captura del Excel
            DataTable dTable = new DataTable();
            DataColumn column = new DataColumn();

            column = new DataColumn();
            column.DataType = System.Type.GetType("System.Int32");
            column.ColumnName = "Concepto";
            dTable.Columns.Add(column);

            column = new DataColumn();
            column.DataType = System.Type.GetType("System.String");
            column.ColumnName = "NombreConcepto";
            dTable.Columns.Add(column);

            column = new DataColumn();
            column.DataType = System.Type.GetType("System.Int32");
            column.ColumnName = "Legajo";
            dTable.Columns.Add(column);

            column = new DataColumn();
            column.DataType = System.Type.GetType("System.String");
            column.ColumnName = "Nombre";
            dTable.Columns.Add(column);

            column = new DataColumn();
            column.DataType = System.Type.GetType("System.Decimal");
            column.ColumnName = "Cantidad";
            dTable.Columns.Add(column);

            column = new DataColumn();
            column.DataType = System.Type.GetType("System.Decimal");
            column.ColumnName = "Importe";
            dTable.Columns.Add(column);

            //Fin Tabla
            int rowCount = xlRange.Rows.Count;
            //int colCount = xlRange.Columns.Count;
            int colCount = 12;
            int iLegajo = 0;
            string sLegaho = "";
            //iterate over the rows and columns and print to the console as it appears in the file
            //excel is not zero based!!
            for (int i = 3; i < rowCount; i++)//La ultima línea no se graba porque son totales generales
            {
                //String[] array = new string[12];
                
                for (int j = 1; j <= colCount; j++)
                {
                    
                    string sValor = "";
                    decimal dCelda = 0;
                   
                    if (j == 1 && String.IsNullOrEmpty(xlRange.Cells[i, j].Value2))
                    {
                       break;
                    }
                    if (j == 1 && !String.IsNullOrEmpty(xlRange.Cells[i, j].Value2.ToString()) && xlRange.Cells[i, j].Value2.ToString() != "Total")
                    {

                        int u = 0;      
                        sValor = xlRange.Cells[i, j].Value2.ToString();
                        u = sValor.Length;
                        iLegajo = Convert.ToInt32(sValor.Substring(0,3));
                        sLegaho = sValor.Substring(4, u - 4).ToString();

                            break;
                       
                    }
                   
                    if (j > 1)
                    {
                        dCelda = Convert.ToDecimal(xlRange.Cells[i, j].Value2);
                        
                        DataRow row = dTable.NewRow();
                       
                        if(j==2 && dCelda > 0 )
                        {
                            row["Concepto"] = 1085;
                            row["NombreConcepto"] = "1085 - Horas Normales";
                            row["Legajo"] = iLegajo;
                            row["Nombre"] = sLegaho;
                            row["Cantidad"] = dCelda;
                            row["Importe"] = 0;
                            dTable.Rows.Add(row);

                        }

                        if (j == 3 && dCelda > 0)
                        {
                            row["Concepto"] = 1115;
                            row["NombreConcepto"] = "1115 - Horas con Plus Nocturno";
                            row["Legajo"] = iLegajo;
                            row["Nombre"] = sLegaho;
                            row["Cantidad"] = dCelda;
                            row["Importe"] = 0;
                            dTable.Rows.Add(row);

                        }

                        if (j == 4 && dCelda > 0)
                        {
                            row["Concepto"] = 1090;
                            row["NombreConcepto"] = "1090 - Horas Extras al 50%";
                            row["Legajo"] = iLegajo;
                            row["Nombre"] = sLegaho;
                            row["Cantidad"] = dCelda;
                            row["Importe"] = 0;
                            dTable.Rows.Add(row);

                        }

                        if (j == 5 && dCelda > 0)
                        {
                            row["Concepto"] = 1100;
                            row["NombreConcepto"] = "1100 - Horas Extras al 100%";
                            row["Legajo"] = iLegajo;
                            row["Nombre"] = sLegaho;
                            row["Cantidad"] = dCelda;
                            row["Importe"] = 0;
                            dTable.Rows.Add(row);

                        }

                        if (j == 6 && dCelda > 0)
                        {
                            row["Concepto"] = 1130;
                            row["NombreConcepto"] = "1130 - Licencia Por Enfermedad";
                            row["Legajo"] = iLegajo;
                            row["Nombre"] = sLegaho;
                            row["Cantidad"] = dCelda;
                            row["Importe"] = 0;
                            dTable.Rows.Add(row);

                        }

                        if (j == 7 && dCelda > 0)
                        {
                            row["Concepto"] = 1060;
                            row["NombreConcepto"] = "1060 - Licencia Por Fallecimiento";
                            row["Legajo"] = iLegajo;
                            row["Nombre"] = sLegaho;
                            row["Cantidad"] = dCelda;
                            row["Importe"] = 0;
                            dTable.Rows.Add(row);

                        }

                        if (j == 8 && dCelda > 0)
                        {
                            row["Concepto"] = 1070;
                            row["NombreConcepto"] = "1070 - Licencia por Nacimiento";
                            row["Legajo"] = iLegajo;
                            row["Nombre"] = sLegaho;
                            row["Cantidad"] = dCelda;
                            row["Importe"] = 0;
                            dTable.Rows.Add(row);

                        }

                        if (j == 9 && dCelda > 0)
                        {
                            row["Concepto"] = 1080;
                            row["NombreConcepto"] = "1080 - Licencia por Examen";
                            row["Legajo"] = iLegajo;
                            row["Nombre"] = sLegaho;
                            row["Cantidad"] = dCelda;
                            row["Importe"] = 0;
                            dTable.Rows.Add(row);

                        }

                        if (j == 10 && dCelda > 0)
                        {
                            row["Concepto"] = 1220;
                            row["NombreConcepto"] = "1220 - Licencia Especial";
                            row["Legajo"] = iLegajo;
                            row["Nombre"] = sLegaho;
                            row["Cantidad"] = dCelda;
                            row["Importe"] = 0;
                            dTable.Rows.Add(row);

                        }

                        if (j == 11 && dCelda > 0)
                        {
                            row["Concepto"] = 1050;
                            row["NombreConcepto"] = "1050 - Licencia Donación de Sangre";
                            row["Legajo"] = iLegajo;
                            row["Nombre"] = sLegaho;
                            row["Cantidad"] = dCelda;
                            row["Importe"] = 0;
                            dTable.Rows.Add(row);

                        }

                        if (j == 12 && dCelda > 0)
                        {
                            row["Concepto"] = 1250;
                            row["NombreConcepto"] = "1250 - Licencia Casamiento";
                            row["Legajo"] = iLegajo;
                            row["Nombre"] = sLegaho;
                            row["Cantidad"] = dCelda;
                            row["Importe"] = 0;

                            dTable.Rows.Add(row);
                        }                     
  
                    }
                                
                }
            }

         
            //cleanup
            GC.Collect();
            GC.WaitForPendingFinalizers();

            Marshal.ReleaseComObject(xlRange);
            Marshal.ReleaseComObject(xlWorksheet);

            //close and release
            xlWorkbook.Close();
            Marshal.ReleaseComObject(xlWorkbook);

            //quit and release
            xlApp.Quit();
            Marshal.ReleaseComObject(xlApp);
            DataSet unDS = new DataSet();
            unDS.Tables.Add(dTable);

            GridView1.DataSource = unDS;

            GridView1.DataBind();
            }
          catch(Exception ex)
            {
                //Response.Write("<script>window.alert('Llegue hasta acá');</script>");
                
              lblError.Text = ex.ToString();
            }
            
        }

        private void SearchAndReplace(string document)
        {
                     
                string docText = null;
                StreamReader sr = new StreamReader(document);
                docText = sr.ReadToEnd();
                sr.Close();


                Regex regexText = new Regex(":0");
                Regex regexText1 = new Regex(":3");
                docText = regexText.Replace(docText, ",0");
                docText = regexText1.Replace(docText, ",5");

                StreamWriter sw = new StreamWriter(document);
               
                sw.Write(docText);
                sw.Close();
                
            
          
        }

     

    
        protected void btnAgregar_Click2(object sender, EventArgs e)
        {
            string strFileName;
            string sPath;
            
            strFileName = fuNovedades.PostedFile.FileName;

            sPath = "\\\\INTRANET\\RRHH\\";
            string sArchivo = sPath + strFileName;

            if (!String.IsNullOrEmpty(strFileName))
            {
                SearchAndReplace(sArchivo);
                getExcelFile(sArchivo);
                btnExcel.Visible = true;
            }
            else 
            {
                Response.Write("<script>window.alert('No Ha Seleccionado ningún Archivo');</script>");
            
            }
          
        

        }

        protected void btnExcel_Click(object sender, ImageClickEventArgs e)
        {
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

            Page.Response.AddHeader("Content-Disposition", "attachment; filename=Novedades.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
        }
     
    }

       
}
