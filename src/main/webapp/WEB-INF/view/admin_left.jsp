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

<title>admin_left</title>

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
body {
	border-right: solid #D0D0D0 1px;
}

#left {
	margin-top: 0px;
}
</style>
</head>

<body>
	<div class="container-fluid">
		<div class="list-group" id="left">
		    <a href="admin/admin_right" class="list-group-item" target="rightFrame"><b>首页</b></a>
			<a href="admin/admin_userbManage" class="list-group-item" target="rightFrame"><b>用户管理</b></a>
			<a href="admin/admin_reportManage" class="list-group-item" target="rightFrame"><b>投诉管理</b></a>
			<a href="admin/admin_msgManage" class="list-group-item" target="rightFrame"><b>短信息管理</b></a>
			<a href="admin/admin_postingsManage" class="list-group-item" target="rightFrame"><b>帖子管理</b></a>
			<a href="admin/admin_detailsManage" class="list-group-item" target="rightFrame"><b>回答管理</b></a>
			<a href="admin/admin_commentsManage" class="list-group-item" target="rightFrame"><b>评论管理</b></a>
			<a href="admin/admin_themeManage" class="list-group-item" target="rightFrame"><b>主题管理</b></a>
			<a href="admin/admin_adminManage" class="list-group-item" target="rightFrame"><b>管理员信息管理</b></a>
			<a href="admin/admin_logManage" class="list-group-item" target="rightFrame"><b>日志管理</b></a>
		</div>
	</div>
</body>
</html>
