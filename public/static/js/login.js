/**
 * Created by Administrator on 2017/12/22.
 */

var app = angular.module('myApp',[]);
app.controller('myCtrl', function($scope,$http) {
    /*
        测试阶段：超级管理员用户名和密码都写在输入框里了，不用手动输入
    */
    $scope.name = 'root';
    $scope.password = 'a12345';
    $scope.login=function()
    {
        var user1={
            'uname':$scope.name,
            'upwd':$scope.password,
            'code':$scope.code
        };
        if(user1['code']!==undefined &&user1['uname']!==undefined && user1['upwd']!==undefined  )
        {
            $http({
                method: 'POST',
                url: url,
                data:user1
            }).then(function successCallback(response) {
                var res=response.data;
                if(res.code==10002) //验证码输入错误
                {
                    alert(res.msg);
                }else if(res.code==10001){  //用户名或者密码输入错误
                    alert(res.msg);
                }else if(res.code==10000)   //登录成功
                {
                    alert(res.msg);
                    location.href=url_index;
                }else if(res.code == 10003)//账号被锁定了
                {
                    alert(res.msg);
                }
            }, function errorCallback(response) {
                // 请求失败执行代码
            });
        }else{
            alert("用户名密码，验证码不能为空");
        }

    };
});