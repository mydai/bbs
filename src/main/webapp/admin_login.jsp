<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>短信息论坛后台管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    <link rel="stylesheet" type="text/css" href="resources/bootstrap-3.3.7/css/bootstrap.css">
	<style type="text/css">
	   body{
	        background-color: #F8F8FF;
	   }
	   .center-block {
	      margin-top:12%;
		}
       .color{
/*           border:1px solid red; */
       }
	</style>
	    

  </head>
  <body>
    <div class="container center-block color">
       <h1 class="text-center">后台管理</h1>
       <div class="col-sm-6 col-sm-offset-3 col-md-4 col-md-offset-4">
		  <div class="form-group">
		    <label for="name">管理员账号</label>
		    <input type="text" class="form-control input-lg" id="name" placeholder="账号">
		  </div>
		  <div class="form-group">
		    <label for="pass">管理员密码</label>
		    <input type="password" class="form-control input-lg" id="pass" placeholder="密码">
		  </div>
		  <button type="button" class="btn btn-primary btn-lg" onclick="admin_login()">登录</button>
		  <button type="button" class="btn btn-default btn-lg col-xs-offset-3 col-sm-offset-5 col-md-offset-3" onclick="findPass()">忘记密码?</button>
       </div>
    </div>
  	<script type="text/javascript" src="resources/amazeui/js/jquery-2.1.4.js"></script>
    <script type="text/javascript" src="resources/layui/lay/dest/layui.all.js"></script>  
    <script type="text/javascript">
       $('#name').focus();
       document.onkeydown = keyListener;
		function keyListener(e) {
			// 当按下回车键，执行我们的代码
			if (e.keyCode == 13) {
				admin_login();
			}
		}
       function admin_login(){
           var name = $('#name').val();
           var pass = $('#pass').val();
           var jsonStr = {
        	   name : name,
        	   pass : pass
           };
           $.ajax({
        	   type:'GET',
        	   contentType:'application/json',
        	   url:'admin/admin_login',
        	   data:jsonStr,
        	   dataType:'json',
        	   success:function(data){
        		   layer.msg(data.tips);
        		   if(data.tips=="登录成功"){
        			   location.href="admin/admin_center";
        		   }
        	   },
        	   error:function(data){
        		   layer.msg('服务器出错，请稍后重试');
        	   }
           });
       }
       function findPass(){
    	   layer.open({
				type : 2,
				title:'后台管理',
				shadeClose : true,
				shade : 0.8,
				offset : '35px',
				area : [ '450px', '550px' ],
				content : 'admin/admin_findPass'
			});
       }
    </script>
  </body>
</html>
