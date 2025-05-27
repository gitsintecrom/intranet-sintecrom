using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Threading;
using System.Reflection;
using System.Globalization;

namespace SintecromNet.Clases
{
    public class AccesoDatos
    {
        SqlConnection unaConexion = null;
        SqlTransaction unaTransaccion = null;
        string BaseDatos = "";

        public AccesoDatos(string unaBase)
        {
            this.BaseDatos = unaBase;
        }

        
        public void AbrirConexion()
        {
            try
            {
                if ( this.unaConexion == null )
                {
                    this.unaConexion = new SqlConnection(ConfigurationManager.ConnectionStrings[BaseDatos].ToString());
                }

                this.unaConexion.Open();
            }
            catch (Exception)
            {
                throw;
            }
        }

        public void CerrarConexion()
        {
            try
            {
                if (this.unaConexion != null)
                {
                    if (this.unaConexion.State == System.Data.ConnectionState.Open)
                    {
                        this.unaConexion.Close();
                    }
                }
            }
            catch (Exception)
            {
                throw;
            }
        }

        public SqlDataReader EjecutarSentencia (string sentencia)
        {
            SqlCommand unComando = null;

            try
            {
                unComando = new SqlCommand(sentencia, this.unaConexion);
                return unComando.ExecuteReader();
            }
            catch (Exception)
            {
                throw;
            }
        }

        public void BeginTran()
        {
            try
            {
                this.unaTransaccion = this.unaConexion.BeginTransaction();
            }
            catch (Exception)
            {
                throw;
            }
        }

        public void CommitTran()
        {
            try
            {
                this.unaTransaccion.Commit();
            }
            catch (Exception)
            {
                throw;
            }
        }

        public void RollbackTran()
        {
            try
            {
                this.unaTransaccion.Rollback();
            }
            catch
            {
                throw;
            }
        }

        public SqlDataReader EjecutarSentencia_Tran(string sentencia)
        {
            SqlCommand unComando = null;

            try
            {
                unComando = new SqlCommand(sentencia, this.unaConexion);
                unComando.Transaction = this.unaTransaccion;
                return unComando.ExecuteReader();
            }
            catch (Exception)
            {
                throw;
            }
        }
        
        public int EjecutarSentencia_NonQuery_Tran(string sentencia)
        {
            SqlCommand unComando = null;

            try
            {
                unComando = new SqlCommand(sentencia, this.unaConexion);
                unComando.Transaction = this.unaTransaccion;
                return unComando.ExecuteNonQuery();
            }
            catch (Exception)
            {
                throw;
            }
        }

        public int EjecutarSentencia_NonQuery(string sentencia)
        {
            SqlCommand unComando = null;

            try
            {
                unComando = new SqlCommand(sentencia, this.unaConexion);
                unComando.CommandTimeout = 0;
                return unComando.ExecuteNonQuery();
            }
            catch (Exception)
            {
                throw;
            }
        }


        public DataSet ExecuteDataSet(SqlCommand Cmd)
        {
            DataSet DTS = new DataSet();
            SqlDataAdapter adapter = null;

            try
            {
                if (Cmd == null)
                {
                    throw new ArgumentNullException("Cmd");
                }

                DTS.Locale = CultureInfo.InvariantCulture;
                adapter = new SqlDataAdapter();
                Cmd.Connection = this.unaConexion;
                Cmd.CommandType = CommandType.StoredProcedure;
                Cmd.CommandTimeout = 0;
                adapter.SelectCommand = Cmd;
                adapter.Fill(DTS);
                return DTS;
            }
            catch
            {
                throw;
            }
            finally
            {
                if (adapter != null)
                {
                    adapter.Dispose();
                }
            }
        }

        public int ExecuteNonQuerySP(SqlCommand Cmd, SqlParameter[] parametros)
        {

            CultureInfo ci = new CultureInfo("");

            if (Cmd == null || parametros == null)
            {
                throw new ArgumentNullException("Cmd");
            }
            else
            {

                try
                {
                    int iParam = 0;
                    int i = 0;

                    Cmd.Parameters.Clear();
                    for (i = 0; i < (int)parametros.Length; i++)
                    {
                        Cmd.Parameters.Add(parametros[i]);
                        iParam++;
                    }

                    Cmd.Connection = this.unaConexion;
                    Cmd.CommandType = CommandType.StoredProcedure;
                    Cmd.CommandTimeout = 0; //Para que no se vaya por timeout la conexión
                    return Cmd.ExecuteNonQuery();
                    

                }
                catch
                {
                   
                    throw;
                }
            }
        }

        public DataSet ExecuteDataSet(SqlCommand Cmd, SqlParameter[] Parametros)
        {
            DataSet DTS = new DataSet();
            SqlDataAdapter adapter = null;

            try
            {
                if (Parametros == null)
                {
                    throw new ArgumentNullException("Parametros");
                }

                if (Cmd == null)
                {
                    throw new ArgumentNullException("Cmd");
                }

                DTS.Locale = CultureInfo.InvariantCulture;
                adapter = new SqlDataAdapter();
                Cmd.Parameters.Clear();
                int iParam = 0;
                int i;
                for (i = 0; i < (int)Parametros.Length; i++)
                {
                    if (Parametros[i].Value == null)
                    {
                        Parametros[i].Value = DBNull.Value;
                    }

                    Cmd.Parameters.Add(Parametros[i]);
                    iParam++;
                }

                Cmd.Connection = this.unaConexion;
                Cmd.CommandType = CommandType.StoredProcedure;
                Cmd.CommandTimeout = 0;
                adapter.SelectCommand = Cmd;
                adapter.Fill(DTS);
                return DTS;
            }
            catch
            {
                throw;
            }
            finally
            {
                if (adapter != null)
                {
                    adapter.Dispose();
                }
            }
        }

        public SqlCommand LogError(
                Guid id,
                string appName,
                string hostName,
                string typeName,
                string source,
                string message,
                string user,
                int statusCode,
                DateTime time,
                string xml)
        {
            SqlCommand command = new SqlCommand("ELMAH_LogError");
            command.CommandType = CommandType.StoredProcedure;

            SqlParameterCollection parameters = command.Parameters;

            parameters.Add("@ErrorId", SqlDbType.UniqueIdentifier).Value = id;
            parameters.Add("@Application", SqlDbType.NVarChar, 30).Value = appName;
            parameters.Add("@Host", SqlDbType.NVarChar, 30).Value = hostName;
            parameters.Add("@Type", SqlDbType.NVarChar, 100).Value = typeName;
            parameters.Add("@Source", SqlDbType.NVarChar, 60).Value = source;
            parameters.Add("@Message", SqlDbType.NVarChar, 500).Value = message;
            parameters.Add("@User", SqlDbType.NVarChar, 50).Value = user;
            parameters.Add("@AllXml", SqlDbType.NText).Value = xml;
            parameters.Add("@StatusCode", SqlDbType.Int).Value = statusCode;
            parameters.Add("@TimeUtc", SqlDbType.DateTime).Value = time;

            return command;
        }
       
    }
}