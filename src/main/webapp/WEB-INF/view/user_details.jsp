<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="czx"%>
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

<title>My JSP 'userDetails.jsp' starting page</title>

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
#img {
	width: 150px;
	height: 150px;
}

h2 {
	margin-top: 5px;
}

textarea {
	margin-top: 10px;
}
</style>

</head>

<body>


	<!-- content start -->
	<div class="admin-content">
		<div class="admin-content-body">
			<div class="am-cf am-padding am-padding-bottom-0">
				<div class="am-fl am-cf">
					<strong class="am-text-primary am-text-lg">个人资料</strong> / <small>Personal
						information</small>
				</div>
			</div>
			<hr />

			<div class="am-g">
				<div class="am-u-sm-12 am-u-md-3 am-u-md-push-8">
					<div class="am-panel am-panel-default">
						<div class="am-panel-bd">
						  <p>您的头像</p>
							<div class="am-g">
								<div class="am-u-md-4" id="img">
										<img class="am-img-circle am-img-thumbnail"
											src="${sessionScope.curr_user.img }" alt="头像" />
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
					<div class="am-form am-form-horizontal">
						<div class="am-form-group">
							<label for="user-name" class="am-u-sm-3 am-form-label">账号
								/ Name:</label>
							<div class="am-u-sm-9">
								<h2>${sessionScope.curr_user.name }</h2>
							</div>
						</div>

						<div class="am-form-group">
							<label for="user-email" class="am-u-sm-3 am-form-label">电子邮件
								/ Email:</label>
							<div class="am-u-sm-9">
								<h2 style="float:left;">${sessionScope.curr_user.email }</h2>
	                            <czx:if test="${sessionScope.curr_user.status ==0}">
                                  <a href="javascript:void(0);" onclick="sendActivateMail()" style="float:left;margin-top:10px;margin-left:14px;font-size:16px;">您的邮箱尚未激活，请立即激活</a>
                                </czx:if>
                                <czx:if test="${sessionScope.curr_user.status ==1}">
                                  <p style="float:left;margin-top:10px;margin-left:13px;font-size:16px;color:green;">邮箱已认证</p>
                                </czx:if>	
							</div>
						</div>

						<div class="am-form-group">
							<label for="user-phone" class="am-u-sm-3 am-form-label">电话
								/ Telephone:</label>
							<div class="am-u-sm-9">
								<h2>${sessionScope.curr_user.phone }</h2>
							</div>
						</div>
						<div class="am-form-group">
							<label for="user-intro" class="am-u-sm-3 am-form-label">简介
								/ Intro:</label>
							<div class="am-u-sm-9">
								<textarea class="" rows="5" id="user-intro" disabled placeholder="输入个人简介">${sessionScope.curr_user.intro }</textarea>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<footer class="admin-content-footer">
		<hr>
		<p class="am-padding-left">© 2014 AllMobilize, Inc. Licensed under
			MIT license.</p>
		</footer>

		<form action="user/login" method="get"></form>
	</div>
	<!-- content end -->
	<!--[if lt IE 9]>
	<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
	<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
	<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
	<![endif]-->

	<!--[if (gte IE 9)|!(IE)]><!-->
	<script src="resources/amazeui/js/jquery-2.1.4.js"></script>
	<!--<![endif]-->
	<script src="resources/amazeui/js/amazeui.js"></script>
	<script src="resources/amazeui/js/app.js"></script>
	<script type="text/javascript" src="resources/layui/lay/dest/layui.all.js"></script>
	<script type="text/javascript">
		function sendActivateMail(){
			$.ajax({
			  type : 'GET',
			  contentType : 'application/json',
			  url : 'user/sendActivateMail',
			  data : '',
			  dataType : 'json',
			  seccess : function(data){
				  layer.msg(data.tips);
			  },
			  error : function(data){
				  layer.msg('服务器出错，请稍后重试');
			  }
			});
		}
	</script>
</body>
</html>
