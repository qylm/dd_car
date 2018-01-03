<?php
namespace app\admin\controller;
/*
引用公共控制器Auto
*/
use \app\admin\controller\Auto;
/*
引用数据库操作类
*/
use \think\Db;
/*
引用session
*/
use \think\Session;
/*
引用指定回复信息格式（json）
*/
use \think\Response;
/*
	使用tp框架的缓存类
*/
use \think\Cache;
/*
	使用tp框架的过滤变量检查变量类
*/
use \think\Request;

class Appraise extends Auto
{
    /*
         1）方法用途：显示后台管理中心
         2）方法参数：
    */

    /*
        引用评论的页面
    */
    public function appraise()  //引用页面
    {
        if(input("?get.findcontent"))  //判断是否搜索输入关键字
        {
            //var_dump(input("?get.findcontent"));
            $dd_content=input('param.findcontent');
            $dd_appraise=Db::table('dd_appraise')->alias('a')
                ->join('dd_applyorder w','a.d_applyorderid = w.d_id')
                ->join('dd_orderinfo c','a.d_applyorderid = c.d_applyorderid')
                ->field('w.d_userid,c.d_userid as d_driverid,a.d_id,a.d_time,a.d_content,a.d_score')
                ->where('a.d_content|a.d_id','like','%'.$dd_content.'%')
                ->paginate(5,false,['query'=>request()->param()]);
            //var_dump($dd_appraise);
            $this->assign('appraiselist',$dd_appraise);
        }else{
            $dd_appraise=Db::table('dd_appraise')->alias('a')
                ->join('dd_applyorder w','a.d_applyorderid = w.d_id')
                ->join('dd_orderinfo c','a.d_applyorderid = c.d_applyorderid')
                ->field('w.d_userid,c.d_userid as d_driverid,a.d_id,a.d_time,a.d_content,a.d_score')
                ->paginate(5,false,['query'=>request()->param()]);
            //var_dump($dd_appraise);
            $this->assign('appraiselist',$dd_appraise);
        }
        return $this->fetch();
    }

}