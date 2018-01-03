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

class Order extends Auto {

    /*
        1）方法用途：显示后台管理中心
        2）方法参数：
   */

    /*
        引用订单详情的页面
    */
    public function orderinfo()
    {
        if(input("?get.datemin") || input("?get.datemax") || input("?get.findorder"))  //判断是否搜索关于订单的关键字
        {
            $arr['stime']=input('param.datemin')?input('param.datemin'):"";  //开始日期
            $arr['etime']=input('param.datemax')?input('param.datemax'):"";  //结束日期
            //订单状态 1 付款状态 2   订单ID 3  用户ID 4
            $arr['way']=input('param.orderoption')?input('param.orderoption'):"";  //查询方式 不需判断为空
            $arr['keyword']=input('param.findorder')?input('param.findorder'):"";       //搜索的关键字
            //var_dump($arr['stime'],$arr['etime'],$arr['way'],$arr['keyword']);
            $where=[];
            foreach($arr as $key=>$value){
                if(!empty($value)){
                        if($key == 'stime'){
                            $where['w.d_starttime'] = ['>=',$value];
                        }
                        if($key =='etime'){
                            $where['w.d_endtime'] = ['<=',$value];
                        }

                        if($key =='keyword' && $arr['way']=='1') {
                            $where['d.d_state']=['like','%'.$value.'%'];
                        }
                        elseif($key =='keyword' && $arr['way']=='2') {
                            $where['c.d_paystate']=['like','%'.$value.'%'];
                        }
                        elseif($key =='keyword' && $arr['way']=='3') {
                            $where['a.d_id']=['like','%'.$value.'%'];
                        }
                        elseif($key =='keyword' && $arr['way']=='4') {
                            $where['a.d_userid']=['like','%'.$value.'%'];
                        }
                    }
                }
                $dd_orderinfo=Db::table('dd_applyorder')->alias('a')
                    ->join('dd_orderinfo w','a.d_id = w.d_applyorderid','left')
                    ->join(' dd_orderpay c','a.d_id = c.d_applyorderid','left')
                    ->join ('dd_orderstatus d','a.d_state = d.d_id','left')
                    ->field('a.d_id,a.d_userid,a.d_uptime,a.d_state,w.d_userid as d_driverid,w.d_starttime,w.d_endtime,w.d_mileage,w.d_gold,c.d_paystate,d.d_state as do_state')
                    ->where($where)
                    ->paginate(4,false,['query'=>request()->param()]);
                        //var_dump($dd_orderinfo);
                    $this->assign('orderinfolist',$dd_orderinfo);
            }
        else{
            $dd_orderinfo=Db::table('dd_applyorder')->alias('a')
                ->join('dd_orderinfo w','a.d_id = w.d_applyorderid','left')
                ->join('dd_orderpay c','a.d_id = c.d_applyorderid','left')
                ->join('dd_orderstatus d','a.d_state = d.d_id','left')
                ->field('a.d_id,a.d_userid,a.d_uptime,a.d_state,w.d_userid as d_driverid,w.d_starttime,w.d_endtime,w.d_mileage,w.d_gold,c.d_paystate,d.d_state as do_state')
                ->paginate(4,false,['query'=>request()->param()]);
                //var_dump($dd_orderinfo);
            $this->assign('orderinfolist',$dd_orderinfo);
        }
        return $this->fetch();
    }
    /*
         订单详情引用遮罩层页面
    */
    public function info()  //订单详情遮罩层引用页面显示的方法
    {
        $orderid=input('orderid');
        //var_dump($orderid);
        $dd_orderinfo=Db::table('dd_applyorder')->alias('a')
            ->join('dd_orderinfo w','a.d_id = w.d_applyorderid ','left')
            ->join('dd_orderpay c','a.d_id = c.d_applyorderid ','left')
            ->join('dd_orderstatus d','a.d_state = d.d_id','left')
            ->where("a.d_id=".$orderid)
            ->field('a.*,w.d_userid as d_driverid,w.d_starttime,w.d_endtime,w.d_mileage,w.d_gold,c.*,d.d_state as do_state')
            ->select();
        //var_dump($dd_orderinfo);
        $this->assign('orderinfolist',$dd_orderinfo);
        return $this->fetch();
    }

    /*执行关闭订单的操作*/

    public function close()
    {
        $orderid=isset($_POST['id'])?$_POST['id']:""; //获取订单id
            /*执行更改订单状态的操作*/
            $dd_modify=Db::table('dd_applyorder')
                ->where('d_id', $orderid)
                ->update(['d_state' => 1]);
            if($dd_modify) {
                /* 1表示 订单可以关闭 并且 已经更改为关闭状态*/
                echo 1;
            }
    }

}
