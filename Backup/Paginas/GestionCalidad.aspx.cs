using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Office.Interop.Excel;
using System.IO;



namespace SintecromNet.Paginas
{
    public partial class GestionCalidad : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
            //Desde Aca
            //string ruta = "//sinte2/Gestion de calidad/CALIDAD SISTEMA 2015/PANTALLA INICIAL.xls";

            ////Definimos un arreglo de tipo Byte
            //Byte[] arrContent;

            ////Una variable FileStream
            //FileStream FS;

            ////Inicializamos nuestra variable
            //FS = null;

            ////Y ahora si extraemos la informacion de nuestro archivo y lo guardamos en nuestra variable FS
            //FS = new FileStream(ruta, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);

            ////Ahora procedemos a obtener nuestro archivo en bytes  lo guardamos en otro arreglo de tipo Byte
            //Byte[] Input = new byte[FS.Length];

            ////Ahora es hora de empezar a leer el archivo y lo guardamos en nuestroarreglo de typo byte y este a su bez a arrContent
            //FS.Read(Input, 0, int.Parse(FS.Length.ToString()));
            //arrContent = (byte[])Input;

            ////Aquí declaramos el tipo de archivo con el cual estamos trabajando
            //string conType = "application/vnd.ms-excel";  //Aqui dependemos de los mime types que necesitemos, en este caso es un pdf, mas abajo encontraran la lista de los mime types.

            ////Agregamos a nuestro response el contentype
            //Response.ContentType = conType;

            ////Y Ahora si procedemos a lanzar el archivo a pantalla, como comente arriba, con IE6 mostraba el archivo en pantalla, ahora lo lanza como una descarga de archivo
            //Response.OutputStream.Write(arrContent, 0, arrContent.Length);

            ////Limpiamos y cerramos nuestra variable FS por que si no, no suelta el archivo y nos muestra un error de que el archivo esta siendo ocupado por otro proceso.

            //FS.Close();
            //FS.Dispose();
            //FS = null;

            //Hasta acá
            //System.IO.FileInfo fil = new System.IO.FileInfo(Server.MapPath("../sinte2/Gestion de calidad/CALIDAD SISTEMA 2015/PANTALLA INICIAL.xls"));
            //System.Text.StringBuilder st = new  System.Text.StringBuilder();
            //fil.OpenWrite();
 
            //string archivo = "//sinte2/Gestion de calidad/CALIDAD SISTEMA 2015/PANTALLA INICIAL.xls";
            //FileStream content = File.Open(archivo, FileMode.Open);
            //try
            //{
            //    FileStream content = File.Open(archivo, FileMode.Open);
            //    //content.Close();
               

            //}
            //catch (Exception) { }
            //System.IO.FileStream content = System.IO.File.Open(@"//sinte2/Gestion de calidad/CALIDAD SISTEMA 2015/PANTALLA INICIAL.xls", System.IO.FileMode.Open);
            //Response.Clear();
            //Response.ContentType = "vnd.ms-excel";
            ////Response.AddHeader("Content-disposition", "attachment; filename=" & "nombre");

            //Response.WriteFile("//sinte2/Gestion de calidad/CALIDAD SISTEMA 2015/PANTALLA INICIAL.xls");

            //Response.Flush();

            //Response.Close();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //// Limpiamos la salida
            //Response.Clear();
            //// Con esto le decimos al browser que la salida sera descargable
            //Response.ContentType = "application/octet-stream";
            //// esta linea es opcional, en donde podemos cambiar el nombre del fichero a descargar (para que sea diferente al original)
            ////Response.AddHeader("Content-Disposition", "attachment; filename= Documentacion/GestionCalidad.exe");
            //// Escribimos el fichero a enviar 
            //Response.WriteFile("../Documentacion/GestionCalidad.exe");
            //// volcamos el stream 
            //Response.Flush();
            //// Enviamos todo el encabezado ahora
            //Response.End();



            //string filename = Request.QueryString.Get("../Documentacion/GestionCalidad.exe");
            string filename =("../Documentacion/GestionCalidad.exe");

             if ( !String.IsNullOrEmpty(filename) )
            { 
              String dlDir = @"Descargas/";
              String path = Server.MapPath(filename);

                 System.IO.FileInfo toDownload =
                   new System.IO.FileInfo(path);

              //if (toDownload.Exists)
              {
                 Response.Clear(); 
                 Response.AddHeader("Content-Disposition",
                            "attachment; filename=" + toDownload.Name);
                 Response.AddHeader("Content-Length", 
                            toDownload.Length.ToString());
                 Response.ContentType = "application/octet-stream";
                 Response.WriteFile(filename);
                 Response.End();
              } 
            } 
        }
    }
}