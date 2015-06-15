<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Main.aspx.cs" Inherits="Main" %>

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
    <style type="text/css">
        body {
            background-color: #fff;
            text-align: center;
        }

        #Result {
            border: 3px solid #40AA53;
            margin: 0 auto;
            text-align: center;
            padding: 50px 0;
            background: #efe;
        }

        #ResultNum {
            font-size: 40pt;
            font-family: Verdana;
        }

        .defin {
            margin: 50px 0 0 0;
        }
    </style>
</head>
<body>
       <%
        string username = Convert.ToString(Session["username"]);
        if (username != "")
        {
            Response.Redirect("teaMain.aspx");
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
                    <li><a style="color: #70BCF3;margin-top: 30px;" href="#" data-toggle="modal" data-target="#login">老师登陆</a></li>
                    <li></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <h1 style="color: #40AA53">随机选择</h1>
                <div id="Result" style="color: #40AA53">
                    <span id="ResultNum">0</span>
                </div>
                <input type='button' id="btn-begin" class="btn btn-success btn-lg defin" value='开始' onclick='beginRndNum(this)' disabled="disabled" />
                <input type='button' id="btn-check" class="btn btn-success btn-lg defin" value='检测评分完毕'/>
            </div>
            <div id="cur-stu-info" class="col-md-4">
                <br />
                <br />
                <br />
                <h1>? ? ?</h1>
            </div>
            <div class="col-md-4">
                <br />
                <br />
                <br />
                <a href="time.html" id="btn_time" class="btn btn-success btn-lg" name="name" target="_blank">倒计时</a>
                <br />
                <br />
               <%-- <div id="score-show" style="display:none">
                    <input type="text" name="score" value="" id="score" />
                    <button class="btn btn-primary" id="s_submit" onclick="submitScore()">提交分数</button>
                </div>--%>
            </div>
        </div>
    </div>
    <!--模态框-->
    <div class="modal fade" id="login" style="color: #6899FC">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h1 class="margin-bottom-15">登录</h1>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal templatemo-container templatemo-login-form-1 margin-bottom-30" role="form" action="#" method="post">
                        <div class="form-group">
                            <div class="col-xs-11">
                                <div class="control-wrapper">
                                    <label for="username" class="control-label fa-label"><i class="icon-user icon-large"></i></label>
                                    <input type="text" class="form-control" id="username" placeholder="用户名" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-11">
                                <div class="control-wrapper">
                                    <label for="password" class="control-label fa-label"><i class="icon-lock icon-large"></i></label>
                                    <input type="password" class="form-control" id="password" placeholder="密码" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-11">
                                <div class="control-wrapper">
                                    <input type="button" id="login_btn" value="登陆" class="btn btn-info" />
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer"></div>
        </div>
    </div>
    <input id="hd_username" type="hidden" value=""/>
</body>
</html>
