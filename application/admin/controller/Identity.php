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

class Identity extends Auto
{
    /*
         1）方法用途：显示司机管理页面
         2）方法参数：
    */
    public function identity(){
        // 判断是否输入了搜索内容
        $keyword = input('?get.keyword')?input('keyword'):'';
        // 获取select框的值
        $sValue = input('?get.sValue')?input('sValue'):'';
        // 判断是否为首次加载页面
        if(empty($keyword) && empty($sValue) && $sValue!=0 && $keyword!=0){  // empty(0)为真
            $list = Db::name('nameauth')
                ->alias('a')
                ->join('user b','a.d_userid=b.d_id')
                ->field('a.d_id as d_id,b.d_tell as d_tell,a.d_name as d_name,b.d_headimg as d_headimg,a.d_type as d_type,a.d_number as d_number,a.d_state as d_state')
                ->paginate(5);
        }else{
            $arr['keyword'] = $keyword;
            if($sValue != -1){  //排除为全部的情况
                $arr['sValue'] = $sValue;
            }
            $where=[];
            foreach ($arr as $key=>$value){
                if(!empty($value)){
                    if($key=='keyword'){
                        $where['b.d_tell|a.d_name|a.d_number'] = ['like','%'.$value.'%'];
                    }
                    if($key=='sValue'){
                        $where['a.d_state'] = ['=',$value];
                    }
                }
            }
            // 查询所有用户数据 并且每页显示5条数据
            $list = Db::name('nameauth')
                ->alias('a')
                ->join('user b','a.d_userid=b.d_id')
                ->where($where)
                ->field('a.d_id as d_id,b.d_tell as d_tell,a.d_name as d_name,b.d_headimg as d_headimg,a.d_type as d_type,a.d_number as d_number,a.d_state as d_state')
                ->paginate(5,false,['query'=>request()->param()]);
        }
        // 把分页数据赋值给模板变量list
        $this->assign('list', $list);
        // 渲染模板输出
        return $this->fetch();
    }

    /*
         1）方法用途：实名认证通过
         2）方法参数：
    */
    public function toSuccess(){
        $did = $_POST['id'];
        $res = Db::name('nameauth')->where('d_id',$did)->update(['d_state'=>'1']);
        //读取配置文件config中自己配置的登录提示内容
        $startMsg = config('msg')['namecheck'];
        if($res){
            return json(['code'=>'1201','msg'=>$startMsg['namecheck_success'],'data'=>[],'did'=>$did]);
        }else{
            return json(['code'=>'1202','msg'=>$startMsg['namecheck_error'],'data'=>[],'did'=>$did]);
        }
    }

    /*
         1）方法用途：实名认证通过
         2）方法参数：
    */
    public function toError(){
        $did = $_POST['id'];
        $res = Db::name('nameauth')->where('d_id',$did)->update(['d_state'=>'0']);
        //读取配置文件config中自己配置的登录提示内容
        $startMsg = config('msg')['namecheck'];
        if($res){
            return json(['code'=>'1201','msg'=>$startMsg['namecheck_success'],'data'=>[],'did'=>$did]);
        }else{
            return json(['code'=>'1202','msg'=>$startMsg['namecheck_error'],'data'=>[],'did'=>$did]);
        }
    }


    /*
        1）方法用途：显示用户的实名认证信息
        2）方法参数：
    */
    /* public function showinfo(){
        // 获取通过路径传过来的司机id
        $did = input('did');
        $list = Db::name('user')
            -> alias('a')
            -> join('userinfo b','a.d_id=b.d_userid and a.d_id='.$did)
            ->find();
        // 把数据赋值给模板变量list
        $this->assign('list', $list);
        return $this->fetch();
    }*/
}