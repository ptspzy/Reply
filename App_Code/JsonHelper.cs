using System.Runtime.Serialization.Json;
using System.IO;
using System.Text;
using System.Web.Script.Serialization;
using System;

 
 
    /// <summary> 
    /// JSON序列化和反序列化辅助类 
    /// </summary>  
    public class JsonHelper 
    {  
         public static  string ToJSONString(object obj)
        {
            System.Reflection.PropertyInfo[] ps = obj.GetType().GetProperties();
            string json = "{";
            int index = 1;
            foreach (System.Reflection.PropertyInfo pi in ps)
            {
                //Name 为属性名称,GetValue 得到属性值(参数this 为对象本身,null)
                string name = pi.Name;
               
                string val = Convert.ToString(pi.GetValue(obj, null));
                //把 javascript 中的特殊字符转成转义字符
                //val = val.Replace("//", "////").Replace("'", "//'").Replace("/"","///"");
                json +="\\\"" + name + "\\\":\"" + val + "\"";
                if (index != ps.Length)
                {
                    json += ",";
                }
                index++;
            }
            json += "}";
            return json;
        }

        /// <summary>  
        /// JSON序列化  
        /// </summary> 
        public static string JsonSerializer<T>(T t) 
        {
            JavaScriptSerializer jss = new JavaScriptSerializer();
            try
            {
                return jss.Serialize(t);
            }
            catch (Exception ex)
            {

                throw new Exception("JSONHelper.ObjectToJSON(): " + ex.Message);
            }
        }  
        /// <summary>  
        /// JSON反序列化  
        /// </summary>  
        public static T JsonDeserialize<T>(string jsonString)  
        {
             JavaScriptSerializer jss = new JavaScriptSerializer();
            try
            {
                return jss.Deserialize<T>(jsonString);
            }
            catch (Exception ex)
            {
                throw new Exception("JSONHelper.JSONToObject(): " + ex.Message);
            }
        }  
    }
