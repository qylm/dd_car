<?php
namespace app\admin\controller;
/*
引用公共控制层
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

class Passenger extends Auto
{
    /*
         1）方法用途：显示乘客管理页面
         2）方法参数：
    */
    public function passenger()
    {
        //判断是否输入了搜索内容
        $keyword = input('?get.keyword')?input('keyword'):'';
        if(empty($keyword)){
            // 查询所有用户数据 并且每页显示5条数据
            $list = Db::name('user')->paginate(5);
            // 把分页数据赋值给模板变量list
            $this->assign('list', $list);
            // 渲染模板输出
            return $this->fetch();
        }else{
            // 搜索查询用户数据 并且每页显示5条数据
            $list = Db::name('user')->where('d_tell|d_nickname','like','%'.$keyword.'%')->paginate(5,false,['query'=>request()->param()]);
            // 把分页数据赋值给模板变量list
            $this->assign('list', $list);
            // 渲染模板输出
            return $this->fetch();
        }
    }

    /*
        1）方法用途：显示乘客详细信息
        2）方法参数：
   */
    public function showinfo(){
        // 获取通过路径传过来的乘客id
        $pid = input('pid');
        $list = Db::name('user')
            -> alias('a')
            -> join('userinfo b','a.d_id=b.d_userid and a.d_id='.$pid)
            ->find();
        // 把数据赋值给模板变量list
        $this->assign('list', $list);
        return $this->fetch();
    }

    /*
        1）方法用途：显示修改密码框
        2）方法参数：
    */
    public function changepwd(){
        return $this->fetch();
    }

    /*
        1）方法用途：锁定乘客
        2）方法参数：乘客id
    */
    public function stop(){
        $pid = $_POST['d_id'];
        $res = Db::name('user')->where('d_id',$pid)->update(['d_state'=>'1']);
        //读取配置文件config中自己配置的登录提示内容
        $stopMsg = config('msg')['stop'];
        if($res){
            return json(['code'=>'1001','msg'=>$stopMsg['stop_success'],'data'=>[],'pid'=>$pid]);
        }else{
            return json(['code'=>'1002','msg'=>$stopMsg['stop_error'],'data'=>[],'pid'=>$pid]);
        }
    }

    /*
        1）方法用途：启用乘客
        2）方法参数：乘客id
    */
    public function start(){
        $pid = $_POST['d_id'];
        $res = Db::name('user')->where('d_id',$pid)->update(['d_state'=>'0']);
        //读取配置文件config中自己配置的登录提示内容
        $startMsg = config('msg')['start'];
        if($res){
            return json(['code'=>'1101','msg'=>$startMsg['start_success'],'data'=>[],'pid'=>$pid]);
        }else{
            return json(['code'=>'1102','msg'=>$startMsg['start_error'],'data'=>[],'pid'=>$pid]);
        }
    }

}