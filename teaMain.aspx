<%@ Page Language="C#" AutoEventWireup="true" CodeFile="teaMain.aspx.cs" Inherits="teaMain" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>demo</title>
    <!-- Bootstrap -->
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="http://cdn.bootcss.com/jquery/1.11.2/jquery.min.js"></script>
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="http://cdn.bootcss.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <script src="js/page_main.js"></script>
</head>
<body>
    <%
        //Session["username"] = "admin";
        string username = "";
        try
        {
            username = Convert.ToString(Session["username"]);

        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
        if ("" == username)
        {
            //Response.Redirect("Main.aspx");
        }
    %>
    <form runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:HiddenField ID="HF_stu_id" runat="server" Value="" />
    </form>
    <div class="navbar navbar-default" role="navigation" id="menu-nav">
        <div class="container">
            <div class="navbar-header" id="navbar">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">切换导航</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#" style="font-size: 20px;"></a>
            </div>
            <div class="collapse navbar-collapse navbar-responsive-collapse">
                <ul class="nav navbar-nav">
                    <li><a href="index.aspx"></a></li>
                    <li><a href="#">
                        <h1>答辩随机选择系统</h1>
                    </a></li>
                    <li><a style="color: #70BCF3; margin-top: 30px;" href="#" data-toggle="modal" data-target="#login">老师登陆</a></li>
                    <li>
                        <div style="color: blue; margin-top: 45px;"><%=showUsername %></div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div id="cur-stu-info" class="col-md-6">
                <br />
                <br />
                <br />
                <h1>? ? ?</h1>
            </div>
            <div class="col-md-6">
                <br />
                <br />
                <br />
                <button class="btn btn-primary btn-lg" id="show-stu-info">获取当前答辩学生信息</button>
                <br />
                <br />
                <div class="input-group">           
                    <input type="text" name="score" value="" id="score" />
                </div>
                <br/>
                <button class="btn btn-primary" id="s_submit" onclick="submitScore()">提交分数</button>
            </div>
        </div>
    </div>
</body>
</html>

