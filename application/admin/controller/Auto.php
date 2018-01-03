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
引用控制层基类
*/
use \think\Controller;

/*
	引号session类
*/
use \think\Session;

class Auto extends Controller
{
    /*
         1）方法用途：公共层构造方法（自动引用;控制器初始化方法，在控制器的方法调用之前首先执行
         2）方法参数：
    */
    public function _initialize()
    {
        /*echo '这是构造函数';*/
        // if(!Session::has('employees_login'))
        // {
        // 	echo "<script> alert('您还未登录，请登录后再进行操作~');location.href = '{:url('admin/Login/login')}'; </script>";
        // }

    }
}
