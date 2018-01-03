<?php
/*
 命名空间（名称空间）：默认进入控制器index
注意事项：
1.控制器名称请以大写字母开头
2.方法名均为小写
3.每个方法注明格式：
 1）方法用途
 2）方法参数
*/
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


class Index extends Auto
{
    /*
         1）方法用途：显示后台管理中心
         2）方法参数：
    */
    public function index()
    {
        /*获取到登录用户存在Session中的角色ID*/
        $d_roleid = Session::get('employees_login')['d_roleid'];
        $this->assign('name',Session::get('employees_login')['d_username']);
       
        $roleStaffRes = Db::name('rolestaff')->alias('a')
        ->join('staff b','a.d_staffid = b.d_id')
        ->where('d_roleid',$d_roleid)->select();
         $this->assign('list',$roleStaffRes);
         // var_dump($roleStaffRes);
        return $this->fetch();
    }

    /*
         1）方法用途：显示欢迎页面
         2）方法参数：
    */
    public function welcome()
    {
        return $this->fetch();
    }
}
