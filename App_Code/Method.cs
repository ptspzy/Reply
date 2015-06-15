using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using System.Data.SqlClient;


/// <summary>
/// Method 的摘要说明
/// </summary>
public class Method
{
	public Method()
	{
		//
		// TODO: 在此处添加构造函数逻辑
		//
	}

    //老师页面显示学生信息
    public static string showInfo(HttpContext context)
    {
        string sql = "SELECT * FROM Reply WHERE stu_order =(SELECT  MAX(stu_order) FROM Reply)";
        DataSet ds = SqlDb.ExecuteSelectSql(sql);
        return Tojson.GetTableToJson(ds.Tables[0]);
    }

    //判断当前两分数是否为空
    public static string canContinue(HttpContext context)
    {
        string id = context.Request.Form["id"];
        string sql = "SELECT canContinue FROM Reply WHERE id = " + id;
        DataSet ds = SqlDb.ExecuteSelectSql(sql);
        string flag = ds.Tables[0].Rows[0][0].ToString();
        return flag;  
    }
    //提交分数
    public static string submit_score(HttpContext context)
    {
        string id = context.Request.Form["id"];
        string score = context.Request.Form["score"];
        string name = context.Request.Form["who"];
        string thename="";
        if (name == "liu") thename = "l_score";
        else thename = "h_score";
        string sql = "update Reply set " + thename + " = " + score + " WHERE stu_id = " + id;
        int a = SqlDb.ExecuteUpdateSql(sql);
        return a.ToString();
    }

    //返回当前学生信息
    public static string curStuInfo(HttpContext context)
    {
        string id = context.Request.Form["id"];
        string sql = "SELECT * FROM Reply WHERE stu_id = " + id;
        DataSet ds = SqlDb.ExecuteSelectSql(sql);
        return Tojson.GetTableToJson(ds.Tables[0]);
    }

    //更新isok
    public static string updateisOk(HttpContext context)
    {
        string id = context.Request.Form["id"];
        string sql = "UPDATE Reply SET isOk='1' WHERE stu_id = " + id;
        int a = SqlDb.ExecuteUpdateSql(sql);
        return a.ToString();
    }

    public static string next_reply(HttpContext context)
    {
        string result = "";
        string strsql_old = "select * from Reply where Cur_reply = 0 update Reply set Cur_reply = 1 where Cur_reply = 0";
        try
        {
            DataSet ds_old = SqlDbHelper.ExecuteSelectSql(strsql_old);
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
        string strsql_now = "select top 1 * from Reply where Cur_reply = -1 order by stu_order";
        DataSet ds_now = SqlDbHelper.ExecuteSelectSql(strsql_now);
        string strsql_now2 = "update Reply set Cur_reply = 0 where stu_id = @stu_id";
        SqlParameter[] pars ={
                                new SqlParameter("@stu_id",ds_now.Tables[0].Rows[0][1].ToString())
                            };
        int num = SqlDbHelper.ExecuteNoQuerySql(strsql_now2, pars);
        string Cur_reply = getCurReply(context);
        string Next_reply = getNextReply(context);
        result = Cur_reply + "|" + Next_reply;
        return result;
    }

    public static string getNextReply(HttpContext context)
    {
        string result = "";
        string strsql = "select top 1 * from Reply where Cur_reply = -1 order by stu_order";
        DataSet ds = SqlDbHelper.ExecuteSelectSql(strsql);
        result = GetTableToJson(ds.Tables[0]);
        return result;
    }
    public static string getCurReply(HttpContext context)
    {
        string result = "";
        string strsql = "select * from Reply where Cur_reply = 0";
        DataSet ds = SqlDbHelper.ExecuteSelectSql(strsql);
        int num = ds.Tables[0].Rows.Count;
        if (num == 0)
        {
            string strsql_add = "update Reply set Cur_reply = 0 where stu_id=(select top 1 stu_id from Reply where Cur_reply = -1 order by stu_order)";
            int num_add = SqlDbHelper.ExecuteNoQuerySql(strsql_add);
            string strsql2 = "select * from Reply where Cur_reply = 0";
            DataSet ds2 = SqlDbHelper.ExecuteSelectSql(strsql2);
            result = GetTableToJson(ds2.Tables[0]);
        }
        else
        {
            result = GetTableToJson(ds.Tables[0]);
        }
        return result;
    }

    public static string login(HttpContext context)
    {
        string result = "";
        string username = context.Request.Form["username"];
        string password = context.Request.Form["password"];
        if (username == "" || password == "")
        {
            result = "用户名或密码为空，请重新输入！";
        }
        else
        {
            string strsql = "select * from Users where username=@username and password=@password";
            SqlParameter[] pars ={
                                    new SqlParameter("@username",username),
                                    new SqlParameter("@password",password)
                                };
            try
            {
                DataSet ds = SqlDbHelper.ExecuteSelectSql(strsql, pars);
                var num = ds.Tables[0].Rows.Count;
                if (num > 0)
                {
                    result = "1";
                    try
                    {
                        HttpContext.Current.Session["username"] = username;
                    }
                    catch (Exception ex)
                    {
                        throw new Exception(ex.Message);
                    }
                }
                else
                {
                    result = "0";
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        return result;
    }

    public static string s_submit(HttpContext context)
    {
        string result = "";
        string strsql = "";
        string score = context.Request.Form["score"];
        string username = HttpContext.Current.Session["username"].ToString();
        //string stu_id = HttpContext.Current.Session["stu_id"].ToString();//*****************************
        string stu_id = "";
        string strsql_stu = "select * from Reply where Cur_reply = '0'";
        DataSet ds = SqlDbHelper.ExecuteSelectSql(strsql_stu);
        stu_id = ds.Tables[0].Rows[0][1].ToString();
        if (score == "")
        {
            result = "成绩为空，不能继续操作！";
        }
        else
        {
            switch (username)
            {
                case "huangmeng":
                    strsql = "update Reply set h_score = @score where stu_id = @stu_id";
                    break;
                case "liushuai":
                    strsql = "update Reply set l_score = @score where stu_id = @stu_id";
                    break;
                case "test":
                    strsql = "update Reply set l_score = @score where stu_id = @stu_id";
                    break;
            }
            SqlParameter[] pars ={
                                    new SqlParameter("@score",score),
                                    new SqlParameter("@stu_id",stu_id)
                                };

            int num = SqlDbHelper.ExecuteNoQuerySql(strsql, pars);
            if (num > 0)
            {
                result = "1";
            }
            else
            {
                result = "0";
            }
        }
        return result;
    }

    public static string getout(HttpContext context)
    {
        string result = "";
        try
        {
            HttpContext.Current.Session.RemoveAll();
            result = "1";
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
        return result;
    }

    /// <summary>
    /// 将dataset转换成Json对象
    /// </summary>
    /// <param name="dt"></param>
    /// <returns></returns>
    public static string GetTableToJson(DataTable dt)
    {
        string str = "[";
        int rows = 0;
        int rowscount = dt.Rows.Count;
        while (rows < rowscount)
        {
            str += "{";
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