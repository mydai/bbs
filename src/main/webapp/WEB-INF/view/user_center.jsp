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

<title>个人中心</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" type="text/css"
	href="resources/bootstrap-3.3.7/css/bootstrap.min.css" />
<style>
</style>
</head>
<frameset rows="55,*" cols="*" frameborder="no" border="0"
	framespacing="0">
	<frame src="user/user_top" name="topFrame" scrolling="no"
		noresize="noresize" id="topFrame" title="topFrame" />
	<frameset cols="187,*" frameborder="no" border="0" framespacing="0">
		<frame src="user/user_left" name="leftFrame" scrolling="no"
			noresize="noresize" id="leftFrame" title="leftFrame" />
		<frame src="user/user_index" name="rightFrame" id="rightFrame"
			title="rightFrame" />
	</frameset>
</frameset>
<noframes>
	<body>
		<script type="text/javascript"
			src="resources/bootstrap/js/jquery-2.1.4.js"></script>
	<script type="text/javascript"
		src="resources/layui/lay/dest/layui.all.js"></script>
	</body>
</noframes>

</html>
