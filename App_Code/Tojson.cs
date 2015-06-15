using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Json 的摘要说明
/// </summary>
public class Tojson
{	
    /// <summary>
    /// 将Table数据集转换为Json形式
    /// </summary>
    /// <param name="context" type="HttpContext">HTTP 请求信息</param>
    /// <param name="dt" type="DataTable">需要转换的数据集</param>
    /// <returns  type="string">转换结果，并将结果转换为字符串形式</returns>
    public static string GetTableToJson(DataTable dt)
    {
        string str = "[";
        int rows = 0;
        int rowscount = dt.Rows.Count;
        while (rows < rowscount)
        {
            str = str + "{";
            int cols = 0;
            int colscount = dt.Columns.Count;
            while (cols < colscount)
            {
                string str3 = str;
                str = str3 + "\"" + dt.Columns[cols].ColumnName + "\":\"" + ((dt.Rows[rows][cols] != DBNull.Value) ? dt.Rows[rows][cols].ToString().Trim().Replace(@"\r", "") : "") + "\",";
                cols++;
            }
            str = str.Substring(0, str.Length - 1) + "},";
            rows++;
        }
        str = str.Substring(0, str.Length - 1) + "]";
        if (dt.Rows.Count > 0)
        {
            return str;
        }
        return string.Empty;
    }
	
}