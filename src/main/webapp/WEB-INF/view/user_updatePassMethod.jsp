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

<title>My JSP 'user_updatePassMethod.jsp' starting page</title>

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
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="resources/amazeui/js/jquery-2.1.4.js"></script>
<!--<![endif]-->
<script src="resources/amazeui/js/amazeui.js"></script>
<script src="resources/amazeui/js/app.js"></script>
</head>

<body>
	<!-- content start -->
	<div class="admin-content">
		<div class="admin-content-body">
			<div class="am-cf am-padding am-padding-bottom-0">
				<div class="am-fl am-cf">
					<strong class="am-text-primary am-text-lg">修改密码方式选择</strong> / <small>choose
						method</small>
				</div>
			</div>

			<hr />
			<div class="">
				<input type="button" class="am-btn am-btn-primary am-btn-lg am-fl"
					id="method1" value="已知旧密码修改" /> <input type="button"
					class="am-btn am-btn-primary am-btn-lg am-fl" id="method1"
					value="通过已激活邮箱修改" />
			</div>
			<hr />
			<footer class="admin-content-footer">
			<hr>
			<p class="am-padding-left">© 2014 AllMobilize, Inc. Licensed
				under MIT license.</p>
			</footer>

		</div>
		<!-- content end -->

</body>
</html>
