
$(function () {
        $("#login_btn").click(function () {
            var username = $("#username").val();
            var password = $("#password").val();
            if (username == "" || password == "") {
                alert("用户名或密码为空，请重新登陆！");
                $("#username").val("");
                $("#username").focus();
            }
            else {
                $.ajax({
                    type: "POST",
                    url: "Handler.ashx",
                    datatype: "text",
                    data: {
                        "method": "login",
                        "username": username,
                        "password": password
                    },
                    success: function (data) {
                        //alert("lianjie success!");
                        if (data == "1") {
                            window.location.reload("teacheraspx.aspx");
                            //document.location("teacheraspx.aspx");
                            $('#login_div').html("<li><strong>" + username + "</strong>，你好！<a id='getout' style='cursor:pointer' onclick='getout()'>退出</a></li>");//可增加为xx老师
                            $("bod").onload();
                        }
                        else if (data == "0") {
                            alert("用户名或密码错误，请重新登陆！");
                            $(".bs-example-modal-lg").show();
                            $("#username").val("");
                            $("#username").focus();
                        }
                        else {
                            alert(data);
                        }
                    },
                    error: function () {
                        alert("***************");
                    }
                });
            }
        })
     
        $("#s_submit").click(function () {
            var score = $("#score").val();
            if (score == "") {
                alert("分数不能为空，请输入！");
                $("#score").val("");
                $("#score").focus();
            } else {
                $.ajax({
                    type: "POST",
                    url: "Handler.ashx",
                    datatype: "text",
                    data: {
                        "method": "s_submit",
                        "score":score
                    },
                    success: function (data) {
                        if (data == "1") {
                            alert("评分成功！");
                            $("#score").val("");
                            $("#next_btn").css("display", "block");
                        } else if (data == "0") {
                            alert("评分失败！");
                        } else {
                            alert(data);
                        }
                    },
                    error: function () { }
                });
            }

        })
        $("#next").click({

        })
});
function getout() {
    $.ajax({
        type: "POST",
        url: "Handler.ashx",
        datatype: "text",
        data: {
            "method": "getout"
        },
        success: function (data) {
            if (data == "1") {
                $('#login_div').html("<a style='color: #70BCF3' href='#' data-toggle='modal' data-target='#login'>登陆</a>");
                //alert("退出成功！");
                //$("#score").val("");
            } else if (data == "0") {
                alert("失败！");
            } else {
                alert(data);
            }
        },
        error: function () { }
    });
}
//点击准备答辩触发事件 
//1、当前答辩 2、下一答辩
//老师给分
$(function () {
    $("#btn_prepare").click(function () {
        $.ajax({
            type: "POST",
            url: "Handler.ashx",
            data: {
                "method": "getCurReply"
            },
            datatype: "json",
            success: function (data) {
                var json = eval('(' + data + ')');
                var htmlstr = "<thead><tr><td class='info'><h2>正在答辩：</h2></td></tr></thead><tbody><tr><td class='info'>学号：</td><td class='info'>" + json[0].stu_id + "</td></tr><tr><td class='info'>姓名：</td><td class='info'>" + json[0].stu_name + "</td></tr><tr><td class='info'>主题：</td><td class='info'>" + json[0].stu_topic + "</td></tr><tr><td class='info'>摘要：</td><td class='info'>" + json[0].description + "</td></tr><tr><td class='info'>所用技术：</td><td class='info'>" + json[0].technology + "</td></tr></tbody>";
                $("#wait-show").html(htmlstr);
            },
            error: function () {
            }
        })
        $.ajax({
            type: "POST",
            url: "Handler.ashx",
            data: {
                "method": "getNextReply"
            },
            datatype: "json",
            success: function (data) {
                var htmlstr = '';
                var json = eval('(' + data + ')');
                htmlstr = "<thead><tr><td class='warning'><h2>下一答辩：</h2></td></tr></thead><tbody><tr><td class='warning'>学号：</td><td class='warning'>" + json[0].stu_id + "</td></tr><tr><td class='warning'>姓名：</td><td class='warning'>" + json[0].stu_name + "</td></tr><tr><td class='warning'>主题：</td><td class='warning'>" + json[0].stu_topic + "</td></tr><tr><td class='warning'>摘要：</td><td class='warning'>" + json[0].description + "</td></tr><tr><td class='warning'>所用技术：</td><td class='warning'>" + json[0].technology + "</td></tr></tbody>";
                $("#next-show").html(htmlstr);
                //$("#score-next").html('<input type="text" name="score" value="" id="score" />  <button class="btn btn-primary" id="s_submit">提交</button>  <button class="btn btn-primary" id="next_btn">下一个</button>')
            },
            error: function () {
            }
        })
    })
 
    $("#next_btn").click(function () {
        $("#next_btn").css("display", "none");
        $.ajax({
            type: "POST",
            url: "Handler.ashx",
            datatype: "text",
            data: {
                "method":"next_reply"
            },
            success: function (data) {
                //alert("succcess");
                var a = new Array();
                a = data.split("|");
                var cur_reply = a[0];
                var next_reply = a[1];
                if (cur_reply != "") {
                    var json1 = eval("(" + cur_reply + ")");
                    var htmlstr = "<thead><tr><td><h2>正在答辩：</h2></td></tr></thead><tbody><tr><td>学号：</td><td>" + json1[0].stu_id + "</td></tr><tr><td>姓名：</td><td>" + json1[0].stu_name + "</td></tr><tr><td>主题：</td><td>" + json1[0].stu_topic + "</td></tr><tr><td>摘要：</td><td>" + json1[0].description + "</td></tr><tr><td>所用技术：</td><td>" + json1[0].technology + "</td></tr></tbody>";
                    $("#wait-show").html(htmlstr);
                    if (next_reply != "") {
                        var json2 = eval("(" + next_reply + ")");
                        var htmlstr = "<thead><tr><td><h2>下一答辩：</h2></td></tr></thead><tbody><tr><td>学号：</td><td>" + json2[0].stu_id + "</td></tr><tr><td>姓名：</td><td>" + json2[0].stu_name + "</td></tr><tr><td>主题：</td><td>" + json2[0].stu_topic + "</td></tr><tr><td>摘要：</td><td>" + json2[0].description + "</td></tr><tr><td>所用技术：</td><td>" + json2[0].technology + "</td></tr></tbody>";
                        $("#next-show").html(htmlstr);
                    }
                    else {
                        var htmlstr = "即将完成答辩！";
                        $("#next-show").html(htmlstr);
                    }
                } else {
                    $("#wait-show").html("完成答辩！稍后，请看总成绩！");
                    $("#next-show").html("");
                }
            },
            error: function () {
                alert("faild");
            }
        })
       
    })
})