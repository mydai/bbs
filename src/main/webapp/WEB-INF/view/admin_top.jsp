<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="czx" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>admin_top</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" type="text/css"
	href="resources/bootstrap-3.3.7/css/bootstrap.css" />
    <style type="text/css">
    #photo{ 
       padding-top:5px; 
       width:40px;
       hright:40px; 
    }
    </style>
  </head>
  
  <body>
    <nav class="navbar navbar-default" role="navigation">
	<div class="container-fluid">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" target="_top"><b>后台管理</b></a>
		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">

			
			<ul class="nav navbar-nav navbar-right nav-tabs" role="tablist">
				<li role="presentation"><a href="admin/admin_logOff"  target="_top"><b>退出登录</b></a></li>
				<!-- 				BootstrapFront?where=logoff -->
			</ul>	
    		<ul class="nav navbar-nav navbar-right nav-tabs" role="tablist">
   				<li role="presentation"><a target="_top"><b>
   				<czx:if test="${sessionScope.curr_admin!=null}">
   				   <p>${sessionScope.curr_admin.name}</p>  
   				</czx:if> </b></a></li>
			</ul>
		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container-fluid --> </nav>
  </body>
</html>
