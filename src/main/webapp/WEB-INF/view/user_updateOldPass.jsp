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

<title>修改密码</title>

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
<style>
.header {
	text-align: center;
}

.header h1 {
	font-size: 200%;
	color: #333;
	margin-top: 30px;
}

.header p {
	font-size: 14px;
}

#validateCode {
	float: left;
}

#image {
	float: left;
	margin-left: 5%;
}
</style>

</head>

<body>
	<div class="header">
		<div class="am-g">
			<h1>修改密码</h1>
		</div>
		<hr />
	</div>
	<div class="am-g">
		<div class="am-u-lg-6 am-u-md-8 am-u-sm-centered">
			<h5></h5>
			<hr>
			<div class="am-form">
				<label for="oldPass">旧密码：</label>
				<div class="am-g">
					<div class="am-u-sm-12">
						<input type="password" name="oldPass" id="oldPass" value="">
						<br>
					</div>
				</div>
				<label for="pass">新密码：</label>
				<div class="am-g">
					<div class="am-u-sm-12">
						<input type="password" name="pass" id="pass" value="">
					</div>
					<br>
				</div>
				<br> <label for="rePass">确认新密码：</label>
				<div class="am-g">
					<div class="am-u-sm-12">
						<input type="password" name="rePass" id="rePass" value="">
					</div>
					<br> <br>
					<div class="am-u-sm-12">
						<input type="button" name="" value="保 存 密 码" id="updateOldPass"
							class="am-btn am-btn-primary am-btn-lg am-fl "
							onclick="updateOldPass()">
					</div>
				</div>
			</div>
			<hr>
			<p>© 2016 daidaizhizuo</p>
		</div>
	</div>
	<script type="text/javascript"
		src="resources/amazeui/js/jquery-2.1.4.js"></script>
	<script type="text/javascript" src="resources/layui/lay/dest/layui.all.js"></script>
	<script type="text/javascript">
		document.onkeydown = keyListener;
		function keyListener(e) {
			// 当按下回车键，执行我们的代码
			if (e.keyCode == 13) {
				updateOldPass();
			}
		}

		function updateOldPass() {
			var oldPass = $('#oldPass').val();
			var pass = $('#pass').val();
			var rePass = $('#rePass').val();

			var jsonStr = {
				oldPass : oldPass,
				pass : pass,
				rePass : rePass
			};

			$.ajax({
				type : 'GET',
				contentType : 'application/json',
				url : 'user/user_doUpdateOldPass',
				data : jsonStr,
				dataType : 'json',
				success : function(data) {
					layer.msg(data.tips);
					if(data.tips=='密码修改成功'){
						setInterval("window.location.href = 'user/user_logOff'", 1000);
					}
				},
				error : function(data) {
					layer.msg('服务器出错，请稍后重试');
				}
			});
		}
	</script>
</body>
</html>
