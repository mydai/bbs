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

<title>用户登录</title>

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
			<h1>用户登录</h1>
		</div>
		<hr />
	</div>
	<div class="am-g">
		<div class="am-u-lg-6 am-u-md-8 am-u-sm-centered">
			<div class="am-form">
				<label for="name">邮箱/手机号/用户名：</label> <input type="text"
					class="am-radius" name="name" id="name" value=""> <br>
				<label for="password">密码:</label> <input type="password"
					class="am-radius" name="pass" id="pass" value=""> <br>
				<label for="validateCode">验证码：</label>
				<div class="am-g">
					<div class="am-u-sm-6">
						<input type="text" class="am-radius" name="yzm" id="yzm" value="">
					</div>
					<div class="am-u-sm-6">
						<img src="<%=path%>/user/showYzm" title="点击刷新" id="image"
							onclick="src='<%=path%>/user/showYzm?validateCode='+Math.random()"><b></b><br />
					</div>
				</div>
				<br> <br>
				<div class="am-cf">
					<div class="am-g">
						<div class="am-u-sm-8">
							<input type="button" name="" value="登 录"
								class="am-btn am-btn-primary am-btn-lg am-fl am-radius"
								onclick="login()">
						</div>
						<div class="am-u-sm-4">
							<a href="<%=path%>/user/register"
								class="am-btn am-btn-primary am-btn-lg am-fl am-radius">注 册</a>
						</div>
						<br> <br>

						<div class="am-u-sm-12">

							<a href="<%=path%>/user/findPass"
								class="am-btn am-btn-default am-btn-sm am-fr am-radius">忘记密码
								^_^? </a>
						</div>
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
		$('#name').focus();
		
		document.onkeydown = keyListener;
		function keyListener(e) {
			// 当按下回车键，执行我们的代码
			if (e.keyCode == 13) {
				login();
			}
		}
		function login() {
			for (var i = 0; i < 3; i++) {
				if ($("input:eq(" + i + ")").val().trim() == "") {
					layer.tips("不能为空!", $("input:eq(" + i + ")"));
					return;
				}
			}
			var name = $('#name').val();
			var pass = $('#pass').val();
			var yzm = $('#yzm').val();
			var jsonStr = {
				name : name,
				pass : pass,
				yzm : yzm
			};
			$.ajax({
				type : 'GET',
				contentType : 'application/json',
				url : 'user/doLogin',
				data : jsonStr,
				dataType : 'json',
				success : function(data) {
					layer.msg(data.tips);
					if (data.tips == '登陆成功') {
						if (window.top == window.self) {//不存在父页面
							window.location.href = 'index.jsp';
						} else {
							parent.location.reload();
						}
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
