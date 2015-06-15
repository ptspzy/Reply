using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;


/// <summary>
/// SqlDbHelper 的摘要说明
/// </summary>
public class SqlDbHelper
{
	public SqlDbHelper()
	{
		//
		// TODO: 在此处添加构造函数逻辑
		//
    }
    private static string CONNECTION_STRING = @"Data Source=172.17.130.147; Initial Catalog=Test; Integrated Security=false;User ID=sa;Password=pzy144";
    /// <summary>
    /// 执行返回影响行数的sql语句
    /// </summary>
    /// <param name="strSql">sql语句</param>
    /// <param name="pars">参数数组</param>
    /// <returns>影响行数</returns>
    public static int ExecuteNoQuerySql(string strSql, params SqlParameter[] pars)
    {
        int ret = -1;
        SqlConnection conn = new SqlConnection(CONNECTION_STRING);
        SqlCommand comm = new SqlCommand(strSql, conn);
        try
        {
            try
            {
                comm.Parameters.AddRange(pars);
                conn.Open();
                ret = comm.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                throw new Exception(ex.Message);
            }
            return ret;
        }
        finally
        {
            comm.Dispose();
            conn.Close();
            conn.Dispose();
        }
    }
    /// <summary>
    /// 执行返回数据集的查询sql语句
    /// </summary>
    /// <param name="strSql">sql语句</param>
    /// <param name="pars">参数数组</param>
    /// <returns>查询数据集</returns>
    public static DataSet ExecuteSelectSql(string strSql, params SqlParameter[] pars)
    {
        DataSet ds = new DataSet();
        SqlConnection conn = new SqlConnection(CONNECTION_STRING);
        SqlCommand comm = new SqlCommand(strSql, conn);
        try
        {
            try
            {
                comm.Parameters.AddRange(pars);
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(comm);
                da.Fill(ds);
            }
            catch (SqlException ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }
        finally
        {
            comm.Dispose();
            conn.Close();
            conn.Dispose();
        }
    }
}