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

<title>My JSP 'right.jsp' starting page</title>

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
<link rel="stylesheet" href="resources/amazeui/css/admin.css">
<style type="text/css">
body {
	border-right: solid #D0D0D0 1px;
}

#left {
	
}
</style>
</head>

<body>

	<!-- sidebar start -->
	<div id="left">
		<ul class="am-list admin-sidebar-list">
			<li><a href="user/user_index" target="rightFrame"><span
					class="am-icon-home"></span> 首页</a></li>
			<li class="admin-parent"><a class="am-cf"
				data-am-collapse="{target: '#collapse-nav'}"><span
					class="am-icon-file"></span> 个人管理 <span
					class="am-icon-angle-right am-fr am-margin-right"></span></a>
				<ul class="am-list am-collapse admin-sidebar-sub" id="collapse-nav">
					<li><a href="user/user_details" class="am-cf"
						target="rightFrame"><span class="am-icon-check"></span> 个人资料<span
							class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
					<li><a href="user/user_updateDetails" target="rightFrame"><span
							class="am-icon-puzzle-piece"></span> 信息修改</a></li>
					<li><a class="am-icon-pencil"
						data-am-collapse="{target: '#pass-nav'}"> 密码修改 <span
							class="am-icon-angle-right am-fr am-margin-right"></span></a>
						<ul class="am-list am-collapse admin-sidebar-sub" id="pass-nav">
							<li><a href="user/user_updateOldPass" target="rightFrame"><span
									class="am-icon-pencil"></span> 通过旧密码</a></li>
							<li><a href="user/user_sendValidate" target="rightFrame"><span
									class="am-icon-pencil"></span> 通过邮箱</a></li>
						</ul></li>
					<li><a href="friend/user_friendManage" target="rightFrame"><span
							class="am-icon-calendar am-icon-envelope"></span> 好友管理</a></li>
				</ul></li>
			<li><a href="user/user_logOff" target="_top"><span
					class="am-icon-sign-out"></span> 注销</a></li>
		</ul>

		<div class="am-panel am-panel-default admin-sidebar-panel">
			<div class="am-panel-bd">
				<p>
					<span class="am-icon-bookmark"></span> 公告
				</p>
				<p>欢迎进入您的个人中心</p>
			</div>
		</div>
	</div>
	<!-- sidebar end -->

	<!--[if (gte IE 9)|!(IE)]><!-->
	<script src="resources/amazeui/js/jquery-2.1.4.js"></script>
	<!--<![endif]-->
	<script src="resources/amazeui/js/amazeui.js"></script>
	<script src="resources/amazeui/js/app.js"></script>
</body>
</html>
