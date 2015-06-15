using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Main : System.Web.UI.Page
{
    public string showUsername = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string username = "";
        try
        {
            username = Convert.ToString(Session["username"]);
            HF_stu_id.Value=username;
            if(username=="huang")showUsername="黄老师已登陆";
            if (username == "liu") showUsername = "刘老师已登陆";
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
        if ("" == username)
        {
            //Response.Redirect("teaMain.aspx");
        }

        string jsonWaitStr = "", jsonOkStr = "";
        string sql_wait = "SELECT * FROM Reply WHERE isOk = '0'";
        string sql_ok = "SELECT * FROM Reply WHERE isOk != '0' ORDER BY stu_order DESC";
        DataSet ds_wait = SqlDb.ExecuteSelectSql(sql_wait);
        DataSet ds_ok = SqlDb.ExecuteSelectSql(sql_ok);
        if (ds_wait.Tables[0].Rows.Count > 0) jsonWaitStr = Tojson.GetTableToJson(ds_wait.Tables[0]);
        if (ds_ok.Tables[0].Rows.Count > 0) jsonOkStr = Tojson.GetTableToJson(ds_ok.Tables[0]);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "chart", "dealWaitJson('" + jsonWaitStr + "');", true);
        
    }
}