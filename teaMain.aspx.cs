using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class teaMain : System.Web.UI.Page
{
    public string showUsername = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string username = "";
        try
        {
            username = Convert.ToString(Session["username"]);
            HF_stu_id.Value = username;
            if (username == "huang") showUsername = "黄老师已登陆";
            if (username == "liu") showUsername = "刘老师已登陆";
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
        if ("" == username)
        {
            Response.Redirect("Main.aspx");
        }
    }
}