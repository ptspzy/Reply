<%@ WebHandler Language="C#" Class="jsHandle" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Data;
using System.Data.SqlClient;

public class jsHandle : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string id = context.Request["stu_id"];
        string flag = context.Request["flag"];
        if (id != "000")
        {
            string sql = "UPDATE Reply SET isOk='1' WHERE stu_id = " + id;
            int a = SqlDb.ExecuteUpdateSql(sql);
        }      
        string jsonWaitStr = "", jsonOkStr = "";
        
        if(flag=="1")//已答辩
        {
            string sql_ok = "SELECT top 10 * FROM Reply WHERE isOk != '0' and Cur_reply=-1 ORDER BY stu_order";
            DataSet ds_ok = SqlDb.ExecuteSelectSql(sql_ok);
            if (ds_ok.Tables[0].Rows.Count > 0) 
                jsonOkStr = Tojson.GetTableToJson(ds_ok.Tables[0]);
            context.Response.Write(jsonOkStr);
            
        }
        else if (flag == "0")//未答辩
        {
            string sql_wait = "SELECT * FROM Reply WHERE isOk = '0'";
            DataSet ds_wait = SqlDb.ExecuteSelectSql(sql_wait);
            if (ds_wait.Tables[0].Rows.Count > 0) 
                jsonWaitStr = Tojson.GetTableToJson(ds_wait.Tables[0]);
            context.Response.Write(jsonWaitStr);
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}