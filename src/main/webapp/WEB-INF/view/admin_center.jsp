<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>后台管理</title>

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
</style>
</head>
 <frameset rows="55,*" cols="*" frameborder="no" border="0"
	framespacing="0">
	<frame src="admin/admin_top" name="topFrame" scrolling="no"
		noresize="noresize" id="topFrame" title="topFrame" />
	<frameset cols="187,*" frameborder="no" border="0" framespacing="0">
		<frame src="admin/admin_left" name="leftFrame" scrolling="no"
			noresize="noresize" id="leftFrame" title="leftFrame" />
		<frame src="admin/admin_right" name="rightFrame" id="rightFrame"
			title="rightFrame" />
	</frameset>
</frameset> 
	<body>
	</body>
	
</html>
