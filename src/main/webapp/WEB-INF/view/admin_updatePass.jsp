<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>修改密码</title>
    
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
       .hh{
         height:30px;
       }
    </style>
       	<script type="text/javascript" src="resources/amazeui/js/jquery-2.1.4.js"></script>
    <script type="text/javascript" src="resources/layui/lay/dest/layui.all.js"></script> 
    <script type="text/javascript">
       function admin_doUpdatePass(){
    	   var pass = $('#pass').val();
    	   var rePass = $('#rePass').val();
    	   var jsonStr = {
    		   pass : pass,
    		   rePass : rePass
    	   };
    	   $.ajax({
    		   type : 'GET',
    		   contentType : 'application/json',
    		   url : 'admin/admin_doUpdatePass',
    		   data : jsonStr,
    		   dataType : 'json',
    		   success : function (data){
    			   layer.msg(data.tips);
    		   },
    		   error : function (data){
    			   layer.msg('服务器出错，请稍后重试');
    		   }
    	   });
       }
    </script>
  </head>
  
  <body>
    <div class="container ">
       <h1 class="text-center">修改密码</h1>
       <div class="col-sm-6">
         <div class="hh"></div>
        <div class="input-group ">
         <label for="pass">新密码</label>
         <input type="password" class="form-control input-lg col-sm-12" id="pass" placeholder="请输入新密码" aria-describedby="basic-addon1">
        </div>
        <div class="hh"></div>
        <div class="input-group">
         <label for="rePass">确认新密码</label>
         <input type="password" class="form-control input-lg " id="rePass" placeholder="请再输入一次新密码" aria-describedby="basic-addon1">
        </div>
        <div class="hh"></div>
          <button class="btn btn-primary btn-lg" onclick="admin_doUpdatePass()">修改密码</button>
        </div>
    </div>

  </body>
</html>
