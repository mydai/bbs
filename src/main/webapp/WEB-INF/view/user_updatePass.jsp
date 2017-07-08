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
			<br>
			<div class="am-form">
				<label for="pass">密码：</label>
				<div class="am-g">
					<div class="am-u-sm-12">
						<input type="password" name="pass" id="pass" value=""> <br>
					</div>
				</div>
				<label for="rePass">确认密码：</label>
				<div class="am-g">
					<div class="am-u-sm-12">
						<input type="password" name="rePass" id="rePass" value=""
							onblur="checkIsError()">
					</div>
					<br> <br> <br>
					<div class="am-u-sm-12">
						<input type="button" class="am-btn am-btn-primary am-btn-lg am-fl"
							value="修 改" onclick="doUpdatePass()" />
					</div>
				</div>
				<br>
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
				doUpdatePass();
			}
		}
		function checkIsError() {
			var pass = $('#pass').val();
			var rePass = $('#rePass').val();
			if ((pass != null) && (rePass != null) && (pass != rePass)) {
				layer.msg('两次密码输入不一致');
			}
		}

		function doUpdatePass() {
			var pass = $("#pass").val();
			var rePass = $("#rePass").val();
			if (pass == "") {
				layer.tips('密码不可为空', $('#pass'));
				return;
			}
			if (rePass == "") {
				layer.tips('重复密码不可为空', $('#rePass'));
			}
			var jsonStr = {
				pass : pass,
				rePass : rePass
			};
			$.ajax({
				type : 'GET',
				contentType : 'application/json',
				url : 'user/doUpdatePass',
				data : jsonStr,
				dataType : 'json',
				success : function(data) {
					layer.msg(data.tips);
					if (data.tips == "密码修改成功") {
						setInterval("location.href = 'user/user_logOff'", 2000);
					}
				},
				error : function(data) {
					layer.msg('服务器出错');
				}
			});
		}
		document.cookie = "name=caoyc;path=/";
	</script>
</body>
</html>
