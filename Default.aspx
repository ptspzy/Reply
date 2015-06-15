<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default"  EnableEventValidation="false" %>

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
            <asp:GridView ID="GV_allShow" class="table table-bordered" runat="server" AutoGenerateColumns="False" DataSourceID="Reply">
                <Columns>                 
                    <asp:BoundField DataField="stu_order" HeaderText="答辩次序" SortExpression="stu_order" />
                    <asp:BoundField DataField="stu_id" HeaderText="学号" SortExpression="stu_id" />
                    <asp:BoundField DataField="stu_name" HeaderText="姓名" SortExpression="stu_name" />
                    <asp:BoundField DataField="stu_topic" HeaderText="答辩题目" SortExpression="stu_topic" />
                    <asp:BoundField DataField="technology" HeaderText="采用技术" SortExpression="technology" />
                    <asp:BoundField DataField="description" HeaderText="简单描述" SortExpression="description" />
                    <asp:BoundField DataField="h_score" HeaderText="分数1" SortExpression="h_score" />
                    <asp:BoundField DataField="l_score" HeaderText="分数2" SortExpression="l_score" />
                    <asp:BoundField DataField="last_score" HeaderText="最后得分" SortExpression="last_score" />


                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="Reply" runat="server" ConnectionString="<%$ ConnectionStrings:TestConnectionString %>" SelectCommand="SELECT * FROM [Reply] ORDER BY [stu_order]"></asp:SqlDataSource>
        </form>
    </div>
</body>
</html>
