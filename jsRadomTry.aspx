<%@ Page Language="C#" AutoEventWireup="true" CodeFile="jsRadomTry.aspx.cs" Inherits="jsRadomTry" %>

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
    <script>
        var original = new Array; //原始数组
        var count = 0;
        //未答辩
        function dealWaitJson(jsonWaitStr) {//后台调用此json处理函数用于显示未答辩学生
            var waitTable = "<thead><tr><td>学号</td><td>姓名</td><td>答辩主题</td><td>...</td></tr></thead>";
            if (jsonWaitStr=='') $("#wait-show").html("<h1><small>答辩完成！！</small></h1>");
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
        //已答辩
        function dealOkJson(jsonOkStr) {//后台调用此json处理函数用于显示答辩学生
            var okTable = "<thead><tr><td>次序</td><td>学号</td><td>姓名</td><td>答辩主题</td><td>...</td></tr></thead>";
            if (jsonOkStr=='')$("#ok-show").html("<h1><small>还没有开始答辩！</small></h1>");
            else {
                var Obj = eval('(' + jsonOkStr + ')');
                for (var i = 0; i < Obj.length; i++) {
                    okTable += '<tr><td class="success">' + Obj[i].stu_order + '</td><td class="success">' + Obj[i].stu_id + '</td><td class="success">' + Obj[i].stu_name + '</td><td class="success">' + Obj[i].stu_topic + '</td><td class="success">...</td></tr>';
                }
                $("#ok-show").html(okTable);
            } 
        }
        $(document).ready(function () {
            var str = '';
            var num;//数组下标
            $("#btn_try").click(function () {//产生随机数
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
                    //已答辩
                    $.ajax({
                        type: "POST",
                        url: "jsHandle.ashx",
                        data: {  "stu_id": '000',"flag": '1' },
                        async: false,
                        datatype: "json",//"xml", "html", "script", "json", "jsonp", "text".       
                        success: function (data) {
                            var okTable = "<thead><tr><td>次序</td><td>学号</td><td>姓名</td><td>答辩主题</td><td>...</td></tr></thead>";
                            //alert('已答辩ajax执行');
                            var Obj = eval('(' + data + ')');
                            for (var i = 0; i < Obj.length; i++) {
                                okTable += '<tr><td class="success">' + Obj[i].stu_order + '</td><td class="success">' + Obj[i].stu_id + '</td><td class="success">' + Obj[i].stu_name + '</td><td class="success">' + Obj[i].stu_topic + '</td><td class="success">...</td></tr>';
                            }
                            $("#ok-show").html(okTable);
                        },
                        //调用出错执行的函数
                        error: function () {
                            alert('AJAX执行出错');
                            //请求出错处理
                        }
                    });
                    //未答辩
                    $.ajax({
                        type: "POST",
                        url: "jsHandle.ashx",
                        data: { "stu_id": '000',"flag": '0' },
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
            });
        });
    </script>
</head>
<body>
   
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
            <div class="collapse navbar-collapse navbar-responsive-collapse">
                <ul class="nav navbar-nav">
                    <li><a href="index.aspx">首页</a></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="container">
        <form runat="server">
            <div class="col-md-4">
                <table id="wait-show" class="table table-hover">    
                </table>
                <%--<asp:GridView ID="GV_isnotOk" runat="server"></asp:GridView>
                <asp:Button ID="Btn_make" runat="server" Text="随机数" OnClick="Btn_make_Click" />--%>
                
            </div>
            <div class="col-md-4">
                <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                <br>
                <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
                <br>
                <input type="button" id="btn_try" class="btn btn-success btn-lg" name="name" value="开始 " />
                <input type="button" id="btn_time" class="btn btn-success btn-lg" name="name" value="倒计时 " />
            </div>
            <div class="col-md-4">
                <table id="ok-show" class="table table-hover">    
                </table>
            </div>

            <asp:HiddenField ID="HF_stu_id" runat="server" Value="000" />
        </form>

    </div>
</body>
</html>
