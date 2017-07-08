<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>消息提醒</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link href="resources/amazeui/css/amazeui.css" type="text/css"
	rel="stylesheet">
  </head>
  
  <body>
    <div class="am-g">
       <div class="am-u-sm-6 am-u-md-6 am-u-lg-6 am-u-sm-offset-5"> 
       <div class="am-vertical-align " style="height: 60%;">
		  <div class="am-vertical-align-middle">
		    <h1>${requestScope.tips}</h1>
            <a href=""><h1>点击返回首页</h1></a>
		  </div>
	   </div>
    </div>
    
   	<script src="resources/amazeui/js/jquery-2.1.4.js"></script>
	<script src="resources/amazeui/js/amazeui.js"></script>
	<script type="text/javascript"
		src="resources/layui/lay/dest/layui.all.js"></script>
  </body>
</html>
