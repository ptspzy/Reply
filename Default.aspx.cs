using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //string sql_show = "select stu_id as '学号',stu_name as '姓名',stu_topic as '答辩题目',description as '简单描述',technology as '运用技术',h_score as '黄老师给分',l_score as '刘老师给分' from Reply order by stu_order";
        //DataSet ds_show = SqlDb.ExecuteSelectSql(sql_show);
        //GV_allShow.DataSource = ds_show;//指定数据源
        //GV_allShow.DataBind();       
    }

}