using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;

/// <summary>
///ThemeJsonObj 的摘要说明
/// </summary>
public class ThemeJsonObj
{
	public ThemeJsonObj()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}
    public ArrayList name { get; set; }
    public ArrayList Address { get; set; }
    public ArrayList Latitude { get; set; }
    public ArrayList Longitude { get; set; }
    public ArrayList Img1 { get; set; } 
    public ArrayList Price { get; set; }
    public ArrayList Level { get; set; }
    public ArrayList BelongCity { get; set; }

    public ArrayList AL_fname { get; set; }
    public ArrayList AL_fadrress { get; set; }
    public ArrayList AL_fimg { get; set; }
    public ArrayList AL_fbelongcity { get; set; }


    public ArrayList HName { get; set; }
    public ArrayList HPrice { get; set; } 
    public ArrayList HImg { get; set; }


}