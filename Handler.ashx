<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;
using System.Web.SessionState;

public class Handler : IHttpHandler, IRequiresSessionState
{
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string result = doMethod(context);
        context.Response.Write(result);
    }

    public static string doMethod(HttpContext context)
    {
        string str = context.Request.Form["method"];
        switch (str)
        {
            case "login":
                return Method.login(context);
            case "s_submit":
                return Method.s_submit(context);
            case "getout":
                return Method.getout(context);
            case "getCurReply":
                return Method.getCurReply(context);
            case "getNextReply":
                return Method.getNextReply(context);
            case "next_reply":
                return Method.next_reply(context);
            case "updateisOk":
                return Method.updateisOk(context);
            case "curStuInfo":
                return Method.curStuInfo(context);
            case "submit_score":
                return Method.submit_score(context);
            case "canContinue":
                return Method.canContinue(context);
            case "showInfo":
                return Method.showInfo(context);
        }
        return ("服务没有找到方法" + str);
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}