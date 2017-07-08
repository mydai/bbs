<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'admin_findPass.jsp' starting page</title>
    
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
       $('#name').focus();
       function admin_doFindPass(){
    	   var name = $('#name').val();
			if ((name == "") || (name == null)) {
				layer.msg('账号不可为空');
				return;
			}
			var jsonStr = {
				name : name
			};
			$.ajax({
				type : 'GET',
				contentType : 'application/json',
				url : 'admin/admin_doFindPass',
				data : jsonStr,
				dataType : 'json',
				success : function(data) {
					layer.msg(data.tips);
				},
				error : function(data) {
					layer.msg(data.tips);
				}
			});
       }
       
       function admin_updatePass(){
    	   var validateCode = $('#validateCode').val();
			if ((validateCode == "") || (validateCode == null)) {
				layer.msg('验证码不可为空');
				return;
			}
			var jsonStr = {
				validateCode : validateCode
			};
			$.ajax({
				type : 'GET',
				contentType : 'application/json',
				url : 'admin/updatePass',
				data : jsonStr,
				dataType : 'json',
				success : function(data) {
					layer.msg(data.tips);
					if (data.tips == "验证码正确") {
						setInterval("location.href = 'admin/admin_updatePass'",
								500);
					}
				},
				error : function(data) {
					layer.msg(data.tips);
				}
			});
       }
    </script>
  </head>
  
  <body>
  
    <div class="container">
      <h1 class="text-center">找回密码</h1>
      <div class="col-sm-6">
         <div class="hh"></div>
         <div class="input-group">
           <span class="input-group-addon" aria-hidden="true"></span>
		   <input type="text" class="form-control input-lg" id="name" placeholder="请输入您的账号" aria-describedby="basic-addon1">
		 </div>
		  <div class="hh"></div>
		 <button class="btn btn-primary btn-lg" onclick="admin_doFindPass()">点击发送验证码</button>
		 <div class="hh"></div>
		 <div class="input-group">
		   <span class="input-group-addon" aria-hidden="true"></span>
		   <input type="text" class="form-control input-lg" id="validateCode" placeholder="请输入验证码" aria-describedby="basic-addon1">
		 </div>
		 <div class="hh"></div>
		 <button class="btn btn-primary btn-lg" onclick="admin_updatePass()">确 定</button>
      </div>
    </div>  

  </body>
</html>
