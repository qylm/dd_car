<?php
namespace app\admin\controller;
/*
引用控制基类
*/
use \think\Controller;
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

class Login extends Controller
{
    public function login()
    {
        return $this->fetch();
    }

    public function dologin()  //登录方法
    {
        if (input('?param.uname') && input('?param.upwd')) {
            //获取
            $uname = input('param.uname');
            $upwd = input('param.upwd');
            $code = input('param.code');
            $loginMsg = config('LoginInfo');  //提示信息
            /*
             * 先对验证码进行校验
             * */
            $checkCode = captcha_check($code);
            if ($checkCode) {
                /*验证码正确后进行用户名密码验证*/

                $where = [
                    'd_username' => $uname,
                    'd_pwd' => $upwd
                ];

                /*查询员工表employees 查看是否有匹配的员工*/
                $res=Db::name('employees')->where($where)->find();
                   if($res == null)
                   {
                        //用户名密码输入错误,查询结果为空
                        return json(['code'=>10001,'msg'=>$loginMsg['login_error'],'data'=>[]]); 
                   }else{
                        if($res['d_state'] != 1)//员工账号被锁定
                        {
                            return json(['code'=>10003,'msg'=>$loginMsg['loginstate_error'],'data'=>[]]); 
                        }else{
                            //登录成功下,将员工信息保存到session中，name为employees_login
                            Session::set('employees_login',$res);
                            //返回结果给客户端
                            return json(['code'=>10000,'msg'=>$loginMsg['login_success'],'data'=>[]]); 
                        }
                    
                   }
            }
            else{
                return json(['code'=>10002,'msg'=>$loginMsg['code_error'],'data'=>[]]); //验证码输入错误
            }
        }
    }
}