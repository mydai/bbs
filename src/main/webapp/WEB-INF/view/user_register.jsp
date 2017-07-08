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

<title>用户注册</title>

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
	margin-top: 15px;
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
			<h1>用户注册</h1>
		</div>
		<hr />
	</div>
	<div class="am-g">
		<div class="am-u-lg-6 am-u-md-8 am-u-sm-centered">
			<div class="am-form">
				<label for="name">用户名：</label> <input type="text" class="am-radius" name="name"
					id="name" value="">  <label for="pass">密码:</label>
				<input type="password" class="am-radius" name="pass" id="pass" value=""> 
				<label for="rePass">确认密码：</label> <input type="password" class="am-radius"
					name="rePass" id="rePass" value="">  <label
					for="email">邮箱：</label> <input type="text" class="am-radius" name="email" id="email"
					value="">  <label for="phone">手机号：</label> <input
					type="text" class="am-radius" name="phone" id="phone" value="">  <label
					for="validateCode">验证码：</label>
				<div class="am-g">
					<div class="am-u-sm-6">
						<input type="text" class="am-radius" name="yzm" id="yzm" value="">
					</div>
					<div class="am-u-sm-6">
						<img src="<%=path%>/user/showYzm" title="点击刷新" id="image"
							onclick="src='<%=path%>/user/showYzm?validateCode='+Math.random()"><b></b><br />
					</div>

				</div>
				<br>
				<div class="am-cf">
					<div class="am-g">
						<div class="am-u-sm-12">
							<input type="button" name="" value="注 册" id="register"
								class="am-btn am-btn-primary am-btn-lg am-fl am-radius" onclick="register()">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript"
		src="resources/amazeui/js/jquery-2.1.4.js"></script>
	<script type="text/javascript" src="resources/amazeui/js/amazeui.js"></script>
    <script type="text/javascript" src="resources/layui/lay/dest/layui.all.js"></script>
	<script type="text/javascript">
		document.onkeydown = keyListener;
		function keyListener(e) {
			// 当按下回车键，执行我们的代码
			if (e.keyCode == 13) {
				register();
			}
		}
		function register(){
			for (var i = 0; i < 6; i++) {
				if ($("input:eq(" + i + ")").val().trim() == "") {
					layer.tips("不能为空!", $("input:eq(" + i + ")"));
					return;
				}
			}
			var name = $('#name').val();
			var pass = $('#pass').val();
			var rePass = $('#rePass').val();
			var email = $('#email').val();
			var phone = $('#phone').val();
			var yzm=$('#yzm').val();
			var jsonStr = {
				name : name,
				pass:pass,
				rePass:rePass,
				email:email,
				phone:phone,
				yzm:yzm
			};
			$.ajax({
				type : 'GET',
				contentType : 'application/json',
				url : 'user/doRegister',
				data : jsonStr,
				dataType : 'json',
				success : function(data) {
					if(data.tips=='注册成功'){
						layer.alert('注册成功，系统已经给您发送了一封带有账号激活链接的邮件，请注意查收', {
							  skin: 'layui-layer-molv' //样式类名
							  ,closeBtn: 0
							}, function(){
								if (window.top == window.self) {//不存在父页面
									window.location.href = 'index.jsp';
								} else {
									parent.location.reload();
								}
							});
					}else{
						layer.msg(data.tips); 
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
