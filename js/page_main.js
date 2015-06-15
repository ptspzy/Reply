/*
1.setTimeout(code,millisec)
	code：必需。要调用的函数后要执行的JavaScript代码串。
	millisec：必需。在执行代码前需等待的毫秒数。
2.clearTimeout(id_of_settimeout) 
	id_of_settimeout：为setTimeout() 返回的 ID 值。该值标识要取消的延迟执行代码块。
*/

var g_Interval = 150;//间隔时间
var count = 0;//记录条数
var g_Timer;
var running = false;
var stu_num = new Array();

//后台调用此json处理函数用于获取未答辩学生信息
function dealWaitJson(jsonWaitStr) {
   
    if (jsonWaitStr == '');
    else {
        var Obj = eval('(' + jsonWaitStr + ')');

        //获取条数
        count = Obj.length;

        //获取信息
        for (var i = 0; i < count; i++) {
            stu_num[i] = Obj[i].stu_id;//获取学号
        }
    }
}
//检测是否评分完毕
$(function () {
    $("#btn-check").click(function () {
        canContinue();
    })
})
//异步判断是否评分完毕
function canContinue() {
    var str = "";
    var id = $("#ResultNum").html();
    if (id == "0") $("#btn-begin").attr("disabled", false);
    $.ajax({
        type: "POST",
        url: "Handler.ashx",
        datatype: "text",
        data: {
            "method": "canContinue",
            "id": id
        },
        success: function (data) {
            str = data;
            if (str == "0" && $("#ResultNum").html() != "0") {
                alert('请等待老师评分完毕！');
                $("#btn-begin").attr("disabled", true);
            } else {
                $("#btn-begin").attr("disabled", false);
            }
        },
        error: function () { }
    });
}
//开始/停止 切换
function beginRndNum(trigger) {//开始
    if (running) {//点击停止
        dealArrayAddNull();//置空处理
        running = false;
        clearTimeout(g_Timer);
        $(trigger).val("开始");
        $('#ResultNum').css('color', 'red');
        $("#btn-check").attr("disabled", false);
        $("#btn-begin").attr("disabled", true);
       
    }
    else {//点击开始
       
        running = true;
        $('#ResultNum').css('color', 'black');
        $(trigger).val("停止");
        
        $("#btn-check").attr("disabled", true);
        if (isNull()) {
            alert('答辩结束！！');
            $("#btn-begin").attr("disabled", true);
            return;
        }
        else {
            beginTimer();
        }
    }
}

function btn_disabledDeal() {
    if ($(trigger).val() == "停止") {
        alert('ddd');
        $("#btn-check").attr("disabled", true);
    }
    else if ($(trigger).val() == "开始") {
        $("#btn-begin").attr("disabled", true);
    }
}

//判断随机数 数组是否为空,避免数组为空时出现死循环
function isNull() {
    var isNull = true;//判空标志
    for (var i = 0; i < stu_num.length; i++) {
        if (stu_num[i] != null) {
            isNull = false;
        }
    }
    return isNull;
}
//产生一个随机数
function updateRndNum() {
    var num = 0; 
    do {
        num = Math.floor(Math.random() * count);
    } while (stu_num[num] == null);//直到数组为空，当数组全为空时为死循环，需要判空 Line53
    $('#ResultNum').html(stu_num[num]);
}

function beginTimer() {
    g_Timer = setTimeout(beat, g_Interval);
}

function beat() {
    g_Timer = setTimeout(beat, g_Interval);
    updateRndNum();
}
//停止按钮触发后台处理函数-->更新updateisOk-->异步显示学生信息
function dealArrayAddNull() {
    ajaxDeal();
    curStuInfo();
    var value=$("#ResultNum").html();
    for (var i = 0; i < count; i++) {
        if (stu_num[i] == value) stu_num[i] = null;
    }
}
//更新updateisOk字段，后台触发器自动作答辩排序
function ajaxDeal() {
    var id = $("#ResultNum").html();
    $.ajax({
        type: "POST",
        url: "Handler.ashx",
        data: {
            "id": id,
            "method": "updateisOk"
        },
        async: false,
        datatype: "json",//"xml", "html", "script", "json", "jsonp", "text".       
        success: function (data) {
            //alert(data);
        },
        //调用出错执行的函数
        error: function () {
            alert('AJAX执行出错');
            //请求出错处理
        }
    });
}
//异步显示学生信息
function curStuInfo() {
    var id = $("#ResultNum").html();
    $.ajax({
        type: "POST",
        url: "Handler.ashx",
        data: {
            "id": id,
            "method": "curStuInfo"
        },
        async: false,
        datatype: "json",//"xml", "html", "script", "json", "jsonp", "text".       
        success: function (data) {
            var curStu = "";
            var Obj = eval('(' + data + ')');
            for (var i = 0; i < Obj.length; i++) {
                curStu += '<br><br><br><h1>现在由' + Obj[i].stu_name + '同学做答辩！</h1><br/><h2>主题为' + Obj[i].stu_topic + '</h2>';
            }
            $("#cur-stu-info").html(curStu);
        },
        //调用出错执行的函数
        error: function () {
            alert('AJAX执行出错');
            //请求出错处理
        }
    });
}

//登陆模块
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
                    alert("登陆成功!");
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
});
//异步提交分数
function submitScore() {
    var id = $("#show-stuid").html();
    var score = $("#score").val();
    var name = $("#HF_stu_id").val();
    if (score == "") {
        alert("分数不能为空，请输入！");
        $("#score").val("");
        $("#score").focus();
    }
    else {
        $.ajax({
            type: "POST",
            url: "Handler.ashx",
            datatype: "text",
            data: {
                "method": "submit_score",
                "who": name,
                "score": score,
                "id": id
            },
            success: function (data) {
                alert("评分成功！");
            },
            error: function () { }
        });
    }
    $("#score").val("");//清空 
}
$(function () {
    var name = $("#HF_stu_id").val();
    
    if (name != ""){
        $("#score-show").css("display", "block");
    }   
    else ;
})

/*实现一个实时更新时间的案例*/
var timeId;
updateTime();
//更新时间
function updateTime() {
    timeId = setTimeout(updateTime, 1000);
    showInfo();
}
//teacher页面异步获取学生信息
$(function () {
    $("#show-stu-info").click(function () {
        showInfo();
    })
})
//异步获取学生信息
function showInfo() {
    $.ajax({
        type: "POST",
        url: "Handler.ashx",
        data: {
            "method": "showInfo"
        },
        async: false,
        datatype: "json",//"xml", "html", "script", "json", "jsonp", "text".       
        success: function (data) {
            //alert(data)
            var curStu = "";
            var Obj = eval('(' + data + ')');
            for (var i = 0; i < Obj.length; i++) {
                curStu += '<br><br><br><h1>现在由<span id="show-stuid">' + Obj[i].stu_id + '</span>' + Obj[i].stu_name + '同学做答辩！</h1><br/><h2>主题为' + Obj[i].stu_topic + '</h2>';
            }
            $("#cur-stu-info").html(curStu);
        },
        //调用出错执行的函数
        error: function () {
            alert('AJAX执行出错');
            //请求出错处理
        }
    });
}