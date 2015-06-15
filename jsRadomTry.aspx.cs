using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class jsRadomTry : System.Web.UI.Page
{ 
    protected void Page_Load(object sender, EventArgs e)
    {
        string jsonWaitStr="", jsonOkStr = "";
        string sql_wait = "SELECT * FROM Reply WHERE isOk = '0'";
        string sql_ok = "SELECT * FROM Reply WHERE isOk != '0' ORDER BY stu_order DESC";
        DataSet ds_wait = SqlDb.ExecuteSelectSql(sql_wait);
        DataSet ds_ok = SqlDb.ExecuteSelectSql(sql_ok);
        if (ds_wait.Tables[0].Rows.Count > 0)jsonWaitStr = Tojson.GetTableToJson(ds_wait.Tables[0]);
        if (ds_ok.Tables[0].Rows.Count > 0) jsonOkStr = Tojson.GetTableToJson(ds_ok.Tables[0]);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "chart", "dealWaitJson('" + jsonWaitStr + "');dealOkJson('" + jsonOkStr + "');", true);
    }
    protected void Btn_make_Click(object sender, EventArgs e)
    {
        //Response.Redirect("http://www.baidu.com");  
        //string id = HF_stu_id.Value;
        //string sql = "UPDATE Reply SET isOk='1' WHERE stu_id = " + id ;
    }
}