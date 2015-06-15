<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta http-equiv="refresh" content="60" />
    <title>demo</title>

    <!-- Bootstrap -->
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">
    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="http://cdn.bootcss.com/jquery/1.11.2/jquery.min.js"></script>
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="http://cdn.bootcss.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <script>
        var original = new Array; //原始数组
        var count = 0;
        //页面加载未排序
        function dealWaitJson(jsonWaitStr) {//后台调用此json处理函数用于显示未答辩学生
            var waitTable = "<thead><tr><td>学号</td><td>姓名</td><td>答辩主题</td><td>...</td></tr></thead>";
            if (jsonWaitStr == '') $("#wait-show").html("<h1><small>答辩完成！！</small></h1>");
            else {
                var Obj = eval('(' + jsonWaitStr + ')');
                count = Obj.length;
                for (var i = 0; i < Obj.length; i++) {
                    waitTable += '<tr><td class="info">' + Obj[i].stu_id + '</td><td class="info">' + Obj[i].stu_name + '</td><td class="info">' + Obj[i].stu_topic + '</td><td class="info">...</td></tr>';
                }
                $("#wait-show").html(waitTable);
            }
            for (var i = 0; i < count; i++) {//获取学号
                original[i] = Obj[i].stu_id;
            }
        }
        //页面加载已排序
        function dealOkJson(jsonOkStr) {//后台调用此json处理函数用于显示答辩学生
            var okTable = "<thead><tr><td>学号</td><td>姓名</td><td>答辩主题</td><td>...</td></tr></thead>";
            if (jsonOkStr == '') $("#ok-show").html("<h1><small>还没有开始答辩！</small></h1>");
            else {
                var Obj = eval('(' + jsonOkStr + ')');
                for (var i = 0; i < Obj.length; i++) {
                    okTable += '<tr><td class="success">' + Obj[i].stu_id + '</td><td class="success">' + Obj[i].stu_name + '</td><td class="success">' + Obj[i].stu_topic + '</td><td class="success">...</td></tr>';
                }
                $("#ok-show").html(okTable);
            }
        }
        $(document).ready(function () {
            var str = '';
            var num;//数组下标
            var times = 0;
            $("#btn_try").click(function () {//产生随机数
                do {
                    times++;
                    var isNull = true;//判空标志
                    for (var i = 0; i < original.length; i++) {
                        if (original[i] != null) {
                            isNull = false;
                        }
                    }
                    if (isNull) alert('答辩结束！！');
                    else {
                        do {
                            num = Math.floor(Math.random() * count);
                        } while (original[num] == null);//直到数组为空
                        str += original[num] + ' - ';
                        $('#Label1').html(str);
                        $('#Label2').html("<h1>请 " + original[num] + "开始答辩！！<h1>");

                        //更新isOk字段
                        $.ajax({
                            type: "POST",
                            url: "jsHandle.ashx",
                            data: { "stu_id": original[num], "flag": '2' },
                            async: false,
                            datatype: "json",//"xml", "html", "script", "json", "jsonp", "text".       
                            success: function (data) {
                                //alert('ajax执行成功！');
                            },
                            //调用出错执行的函数
                            error: function () {
                                alert('AJAX执行出错');
                                //请求出错处理
                            }
                        });
                        //已排序
                        $.ajax({
                            type: "POST",
                            url: "jsHandle.ashx",
                            data: { "stu_id": '000', "flag": '1' },
                            async: false,
                            datatype: "json",//"xml", "html", "script", "json", "jsonp", "text".       
                            success: function (data) {
                                var okTable = "<thead><tr><td>学号</td><td>姓名</td><td>答辩主题</td><td>...</td></tr></thead>";
                                //alert('已答辩ajax执行');
                                var Obj = eval('(' + data + ')');
                                for (var i = 0; i < Obj.length; i++) {
                                    okTable += '<tr><td class="success">' + Obj[i].stu_id + '</td><td class="success">' + Obj[i].stu_name + '</td><td class="success">' + Obj[i].stu_topic + '</td><td class="success">...</td></tr>';
                                }
                                $("#ok-show").html(okTable);
                            },
                            //调用出错执行的函数
                            error: function () {
                                alert('AJAX执行出错');
                                //请求出错处理
                            }
                        });
                        //未排序
                        $.ajax({
                            type: "POST",
                            url: "jsHandle.ashx",
                            data: { "stu_id": '000', "flag": '0' },
                            async: false,
                            datatype: "json",//"xml", "html", "script", "json", "jsonp", "text".       
                            success: function (data) {

                                if (data == '') $("#wait-show").html("<h1><small>答辩完成！！</small></h1>");
                                else {
                                    var waitTable = "<thead><tr><td>学号</td><td>姓名</td><td>答辩主题</td><td>...</td></tr></thead>";
                                    //alert('未答辩ajax执行');
                                    var Obj = eval('(' + data + ')');
                                    for (var i = 0; i < Obj.length; i++) {
                                        waitTable += '<tr><td class="info">' + Obj[i].stu_id + '</td><td class="info">' + Obj[i].stu_name + '</td><td class="info">' + Obj[i].stu_topic + '</td><td class="info">...</td></tr>';
                                    }
                                    $("#wait-show").html(waitTable);
                                }

                            },
                            //调用出错执行的函数
                            error: function () {
                                alert('AJAX执行出错');
                                //请求出错处理
                            }
                        });
                        original[num] = null;
                    }
                } while (times < count);
            });
        });
    </script>
    <script src="js/Teacher.js"></script>
</head>
<body>
    <%
        string username = Convert.ToString(Session["username"]);
        if (username != "")
        {
            Response.Redirect("teacheraspx.aspx");
        }
    %>
    <div class="navbar navbar-inverse " role="navigation" id="menu-nav">
        <div class="container">
            <div class="navbar-header" id="navbar">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">切换导航</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#" style="font-size: 20px;">答辩</a>
            </div>
            <ul class="nav navbar-nav">
                <li><a href="index.aspx">首页</a></li>
                <li><a style="color: #70BCF3" href="#" data-toggle="modal" data-target="#login">老师登陆</a></li>
                <li></li>
            </ul>
        </div>
    </div>
    <div class="container">
        <!--之前显示-->
        <%--<div class="row">
            <div class="col-md-4">
                <table id="ok-show" class="table table-hover">
                </table>
            </div>

            <div class="col-md-4">
               <!--<asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>
                <br>
                <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>
                <br>
               <input type="button" id="btn_try" class="btn btn-success btn-lg" name="name" value="产生答辩随机序列 " />
                <a href="index.html" id="btn_time" class="btn btn-success btn-lg" name="name" target="_blank">倒计时</a>-->
            </div>
            <div class="col-md-4">
                <table id="wait-show" class="table table-hover">
                </table>
            </div>

        </div>--%>
        <form runat="server">
            <asp:HiddenField ID="HF_stu_id" runat="server" Value="000" />
            <div class="row">
                <asp:GridView ID="GV_allShow" class="table table-bordered" runat="server" AutoGenerateColumns="False" DataSourceID="Reply" AllowPaging="True">
                    <Columns>
                        <asp:BoundField DataField="stu_order" HeaderText="答辩次序" SortExpression="stu_order" />
                        <asp:BoundField DataField="stu_id" HeaderText="学号" SortExpression="stu_id" />
                        <asp:BoundField DataField="stu_name" HeaderText="姓名" SortExpression="stu_name" />
                        <asp:BoundField DataField="stu_topic" HeaderText="答辩题目" SortExpression="stu_topic" />
                        <asp:BoundField DataField="technology" HeaderText="采用技术" SortExpression="technology" />
                        <asp:BoundField DataField="description" HeaderText="简单描述" SortExpression="description" />
                        <%--<asp:BoundField DataField="h_score" HeaderText="分数1" SortExpression="h_score" />
                        <asp:BoundField DataField="l_score" HeaderText="分数2" SortExpression="l_score" />
                        <asp:BoundField DataField="last_score" HeaderText="最后得分" SortExpression="last_score" />--%>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="Reply" runat="server" ConnectionString="<%$ ConnectionStrings:TestConnectionString %>" SelectCommand="SELECT * FROM [Reply] ORDER BY [stu_order]"></asp:SqlDataSource>
                <a href="time.html" class="btn btn-primary btn-lg btn-block" target="_blank">开始计时</a>
            </div>
    </form>
    </div>
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
</body>
</html>
