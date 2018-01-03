<?php
namespace app\index\controller;
/*
引用公共控制器Auto
*/
use app\index\controller\Auto;
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

class Express extends Auto
{
    public function express()
    {
        return $this->fetch();
    }
}
