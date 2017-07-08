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

<title>找回密码</title>

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
<span class="am-icon-arrow-left nav-font"><a href="javascript:history.go(-1)" style="color:black;">返回</a></span>
	<div class="header">
		<div class="am-g">
			<h1>找回密码</h1>
		</div>
		<hr />
	</div>
	<div class="am-g">
		<div class="am-u-lg-6 am-u-md-8 am-u-sm-centered">
			<br>
			<div class="am-form">
				<label for="name">账号：</label>
				<div class="am-g">
					<div class="am-u-sm-12">
						<input type="text" class="am-radius" name="name" id="name" value=""> <br>
					</div>
					<div class="am-u-sm-12">
						<input type="button" class="am-btn am-btn-primary am-btn-lg am-fl am-radius"
							value="点 击 发 送 验 证 码" onclick="doFindPass()" />
					</div>
				</div>
				<br> <label for="validateCode">验证码：</label>
				<div class="am-g">
					<div class="am-u-sm-12">
						<input type="text" class="am-radius" name="validateCode" id="validateCode" value="">
					</div>
					<br> <br>
					<div class="am-u-sm-12">
						<input type="button" name="" value="确  定  " id="updatePass"
							class="am-btn am-btn-primary am-btn-lg am-fl am-radius"
							onclick="updatePass()">
					</div>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript"
		src="resources/amazeui/js/jquery-2.1.4.js"></script>
	<script type="text/javascript"
		src="resources/layui/lay/dest/layui.all.js"></script>
	<script type="text/javascript">
		document.onkeydown = keyListener;
		function keyListener(e) {
			// 当按下回车键，执行我们的代码
			if (e.keyCode == 13) {
				updatePass();
			}
		}
		function doFindPass() {
			// 			var jsonStr = $.toJSON($('#form').serializeObject());
			var name = $("#name").val();
			if ((name == "") || (name == null)) {
				layer.msg('账号不可为空');
				return;
			}
			var jsonStr = {
				name : name
			};
			$.ajax({
				type : 'GET',
				contentType : 'application/json',
				url : 'user/doFindPass',
				data : jsonStr,
				dataType : 'json',
				success : function(data) {
					layer.msg(data.tips);
				},
				error : function(data) {
					layer.msg(data.tips);
				}
			});
		}

		function updatePass() {
			var validateCode = $('#validateCode').val();
			if ((validateCode == "") || (validateCode == null)) {
				layer.msg('验证码不可为空');
				return;
			}
			var jsonStr = {
				validateCode : validateCode
			};
			$.ajax({
				type : 'GET',
				contentType : 'application/json',
				url : 'user/updatePass',
				data : jsonStr,
				dataType : 'json',
				success : function(data) {
					layer.msg(data.tips);
					if (data.tips == "验证码正确") {
						setInterval("location.href = 'user/user_updatePass'",
								500);
					}
				},
				error : function(data) {
					layer.msg(data.tips);
				}
			});
		}
	</script>	
</body>
</html>
