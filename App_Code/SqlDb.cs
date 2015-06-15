using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;

/// <summary>
///SqlDb 的摘要说明
/// </summary>
public class SqlDb
{
    private static string CONNECTION_STRING = @"Data Source=172.17.130.147; Initial Catalog=Test;Integrated Security=false;User ID=sa;Password=pzy144;";
	public SqlDb()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}
    public static DataSet ExecuteSelectSql(string strSql)
    {
        SqlConnection conn = new SqlConnection(CONNECTION_STRING);
        SqlDataAdapter da = new SqlDataAdapter(strSql, conn);
        DataSet ds = new DataSet();
        try
        {
            da.Fill(ds);
            return ds;
        }
        catch (Exception ex)
        {
            throw new Exception("执行SQL出现错误：\r\n" + strSql + "\r\n" + ex.ToString());
        }
        finally
        {
            conn.Close();
        }
    }
    public static int ExecuteUpdateSql(string strSql)
    {

        SqlConnection conn = new SqlConnection(CONNECTION_STRING);
        SqlCommand comm = new SqlCommand();
        comm.Connection = conn;
        comm.CommandType = CommandType.Text;
        comm.CommandText = strSql;
        int ret = -1;
        try
        {
            conn.Open();
            ret = comm.ExecuteNonQuery();

            return ret;
        }
        catch (Exception ex)
        {
            throw new Exception("执行SQL出现错误：\r\n" + strSql + "\r\n" + ex.ToString());
        }
        finally
        {
            conn.Close();
        }

        //throw new NotImplementedException();
    }
    public static int ExecuteInsertSql(string strSql)
    {
        int ret = -1;
        SqlConnection conn = new SqlConnection(CONNECTION_STRING);
        SqlCommand comm = new SqlCommand();
        comm.Connection = conn;
        comm.CommandType = CommandType.Text;
        comm.CommandText = strSql;
        try
        {
            conn.Open();
            ret = comm.ExecuteNonQuery();
            return ret;
        }
        catch (Exception ex)
        {
            throw new Exception("执行sql出现错误:\r\n" + strSql + "\r\n" + ex.ToString());
        }
        finally
        {
            conn.Close();
        }
    }
}