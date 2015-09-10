using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;

namespace RealExample
{
    public class DatabaseConnection : IDisposable
    {
        #region "Members"
        private SqlConnection m_oDBConn;
        private SqlCommand m_oCmd = new SqlCommand();
        private SqlDataReader m_oReader;
        private String m_sConnectionString;
        #endregion

        #region "Properties"

        public int CommandTimeout
        {
            get { return m_oCmd.CommandTimeout; }
            set { m_oCmd.CommandTimeout = value; }
        }

        public object CommandObject
        {
            get { return m_oCmd; }
        }

        public object DataReaderObject
        {
            get { return m_oReader; }
        }

        public object ConnectionObject
        {
            get { return m_oDBConn; }
        }

        public string ConnectionString
        {
            get { return m_sConnectionString; }
            set { m_sConnectionString = value; }
        }

        public object ParameterCount
        {
            get { return m_oCmd.Parameters.Count; }
        }

        public object ConnectionState
        {
            get { return m_oDBConn.State; }
        }

        #endregion

        #region "Constructors"

        public DatabaseConnection()
            : base()
        {
            m_oDBConn = new SqlConnection();
        }

        public DatabaseConnection(string sConnectionString)
        {
            ConnectionString = sConnectionString;

            m_oDBConn = new SqlConnection(sConnectionString);
            m_oDBConn.Open();
        }

        public DatabaseConnection(ref SqlConnection oConn)
        {
            m_oDBConn = oConn;
            ConnectionString = m_oDBConn.ConnectionString;
        }
        #endregion

        #region "Methods"


        public void AddParameter(String sParamName, Object oParamVal, System.Data.ParameterDirection enumDirection)
        {
            m_oCmd.Parameters.AddWithValue(sParamName, oParamVal);
            m_oCmd.Parameters[sParamName].Direction = enumDirection;

        }

        public void AddParameter(String sParamName, Object oParamVal, System.Data.ParameterDirection enumDirection, System.Data.SqlDbType enumType)
        {
            m_oCmd.Parameters.AddWithValue(sParamName, oParamVal);
            m_oCmd.Parameters[sParamName].SqlDbType = enumType;
            m_oCmd.Parameters[sParamName].Direction = enumDirection;
        }

        public void AddParameter(String sParamName, Object oParamVal, System.Data.ParameterDirection enumDirection, System.Data.SqlDbType enumType, int enumSize)
        {
            m_oCmd.Parameters.AddWithValue(sParamName, oParamVal);
            m_oCmd.Parameters[sParamName].SqlDbType = enumType;
            m_oCmd.Parameters[sParamName].Size = enumSize;
            m_oCmd.Parameters[sParamName].Direction = enumDirection;
        }


        public Object GetParameterValue(String sParamName)
        {
            return m_oCmd.Parameters[sParamName].Value;
        }

        public void RemoveParameter(Object oParamVal)
        {
            m_oCmd.Parameters.Remove(oParamVal);
        }

        public void ClearParameters()
        {
            m_oCmd.Parameters.Clear();
        }

        public void ClearCommand()
        {
            m_oCmd.Parameters.Clear();
            m_oCmd.CommandText = "";
        }

        public long ExecuteCommand(String sCommandText, System.Data.CommandType oCommandType)
        {
            m_oCmd.Connection = m_oDBConn;
            m_oCmd.CommandType = oCommandType;
            m_oCmd.CommandText = sCommandText;

            m_oReader = m_oCmd.ExecuteReader();

            m_oReader.Close();
            m_oCmd.Dispose();

            return m_oReader.RecordsAffected;
        }

        public int ExecuteScalar(String sCommandText, System.Data.CommandType oCommandType)
        {
            m_oCmd.Connection = m_oDBConn;
            m_oCmd.CommandType = oCommandType;
            m_oCmd.CommandText = sCommandText;
           
            return Convert.ToInt32(m_oCmd.ExecuteScalar());
        }

        public System.Data.DataSet GetDataSet(String sCommandText, System.Data.CommandType oCommandType, String sReturnTableName, System.Data.DataSet oDataSet)
        {
            return GetData(sCommandText, oCommandType, sReturnTableName, ref oDataSet);
        }

        //public System.Data.DataSet GetDataSet(String sCommandText, System.Data.CommandType oCommandType, String sReturnTableName)
        //{
        //    return GetData(sCommandText, oCommandType, sReturnTableName, ref null);
        //}




        public System.Data.DataSet GetData(String sCommandText, System.Data.CommandType oCommandType, String sReturnTableName, ref System.Data.DataSet oDataSet)
        {


            if (oDataSet != null)
            {
                oDataSet = new System.Data.DataSet();
            }

            m_oCmd.Connection = m_oDBConn;
            m_oCmd.CommandType = oCommandType;
            m_oCmd.CommandText = sCommandText;

            using (SqlDataAdapter oDataAdapter = new SqlDataAdapter(m_oCmd))
            {
                oDataAdapter.Fill(oDataSet, sReturnTableName);
            }

            return oDataSet;
        }

        public System.Data.DataSet GetAllData(String sCommandText, System.Data.CommandType oCommandType, ref System.Data.DataSet oDataSet)
        {


            if (oDataSet != null)
            {
                oDataSet = new System.Data.DataSet();
            }

            m_oCmd.Connection = m_oDBConn;
            m_oCmd.CommandType = oCommandType;
            m_oCmd.CommandText = sCommandText;

            using (SqlDataAdapter oDataAdapter = new SqlDataAdapter(m_oCmd))
            {
                oDataAdapter.Fill(oDataSet);
            }

            return oDataSet;
        }

        public void ResetCommandTimeout()
        {
            m_oCmd.ResetCommandTimeout();
        }

        public void CancelCommand()
        {
            m_oCmd.Cancel();
        }

        public Boolean ContainsParameter(Object oValue)
        {
            return m_oCmd.Parameters.Contains(oValue);
        }

        public void OpenConnection(String sConnectionString)
        {
            m_oDBConn.ConnectionString = sConnectionString;
            m_oDBConn.Open();

            ConnectionString = ConnectionString;
        }

        public void OpenConnection()
        {
            OpenConnection(m_sConnectionString);
        }

        public void CloseConnection()
        {
            m_oDBConn.Close();
        }

        public void Dispose()
        {
            if (m_oDBConn.State == System.Data.ConnectionState.Open)
            {
                m_oDBConn.Close();
            }
            m_oDBConn.Dispose();

            if (m_oCmd != null)
            {
                m_oCmd.Dispose();
                m_oCmd = null;
            }

            if (m_oReader != null)
            {
                if (m_oReader.IsClosed != true)
                {
                    m_oReader.Close();
                    m_oReader.Dispose();
                    m_oReader = null;
                }
            }

            if (m_oDBConn != null)
            {
                m_oDBConn.Dispose();
                m_oDBConn = null;
            }
        }

        public System.Data.DataSet GetMultipleTableDataSet(string sCommandText, System.Data.CommandType oCommandType, ref System.Data.DataSet oDataSet, ref String[] sReturnTableNames)
        {
            int NoTableCount = -10;
            return GetMultipleTableData(sCommandText, oCommandType, ref oDataSet, ref sReturnTableNames, ref NoTableCount);
        }

        public System.Data.DataSet GetMultipleTableDataSet(string sCommandText, System.Data.CommandType oCommandType, ref System.Data.DataSet oDataSet, ref String[] sReturnTableNames, ref int TableCount)
        {
            return GetMultipleTableData(sCommandText, oCommandType, ref oDataSet, ref sReturnTableNames, ref TableCount);
        }

        private System.Data.DataSet GetMultipleTableData(string sCommandText, System.Data.CommandType oCommandType, ref System.Data.DataSet oDataSet, ref string[] sReturnTableNames, ref int TableCount)
        {
            if (oDataSet != null)
            {
                oDataSet = new System.Data.DataSet();
            }

            m_oCmd.Connection = m_oDBConn;
            m_oCmd.CommandType = oCommandType;
            m_oCmd.CommandText = sCommandText;
            using (SqlDataAdapter oDataAdapter = new SqlDataAdapter(m_oCmd))
            {
                oDataAdapter.Fill(oDataSet);
            }

            TableCount = oDataSet.Tables.Count;

            for (int i = 0; i <= TableCount - 1; i++)
            {
                if (i <= sReturnTableNames.Length - 1)
                {
                    oDataSet.Tables[i].TableName = sReturnTableNames[i];
                }
            }
            return oDataSet;
        }

        public static int ExecuteNonQuery(string sql, CommandType cmdType, string conStr, params SqlParameter[] pms)
        {

            using (SqlConnection con = new SqlConnection(conStr))
            {
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.CommandType = cmdType;
                    if (pms != null)
                    {
                        cmd.Parameters.AddRange(pms);
                    }
                    con.Open();
                    return cmd.ExecuteNonQuery();
                }
            }
        }

        public static object ExecuteScalar(string sql, CommandType cmdType, string conStr, params SqlParameter[] pms)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.CommandType = cmdType;
                    if (pms != null)
                    {
                        cmd.Parameters.AddRange(pms);
                    }
                    con.Open();
                    return cmd.ExecuteScalar();
                }
            }
        }

        public static SqlDataReader ExecuteReader(string sql, CommandType cmdType, string conStr, params SqlParameter[] pms)
        {
            SqlConnection con = new SqlConnection(conStr);
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.CommandType = cmdType;
                if (pms != null)
                {
                    cmd.Parameters.AddRange(pms);
                }
                try
                {
                    con.Open();
                    return cmd.ExecuteReader(CommandBehavior.CloseConnection);

                }
                catch (Exception)
                {
                    con.Close();
                    con.Dispose();
                    throw;
                }
            }
        }

        public static DataTable ExecuteDataTable(string sql, CommandType cmdType, string conStr, params SqlParameter[] pms)
        {
            DataTable dt = new DataTable();
            using (SqlDataAdapter adapter = new SqlDataAdapter(sql, conStr))
            {
                adapter.SelectCommand.CommandType = cmdType;
                if (pms != null)
                {
                    adapter.SelectCommand.Parameters.AddRange(pms);
                }
                adapter.Fill(dt);
            }

            return dt;
        }

        #endregion
    }
}
