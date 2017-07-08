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

<title>发送私信</title>

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
<link href="resources/layui/css/layui.css" type="text/css"
	rel="stylesheet">
<style>
.header {
	text-align: center;
	margin-top: 15px;
}

h1 {
	font-size: 30px;
}

.color {
	/* 	border: 1px solid red; */
	
}

.descript {
	margin: 5px;
}

.btn-width {
	width: 40%;
}

.div-height {
	height: 98%;
}

.nav-font {
	font-size: 18px;
}
</style>

</head>

<body>
	<div class="am-u-md-12 div-height">
		<span class="am-icon-arrow-left nav-font"><a
			href="javascript:history.go(-1)">返回</a></span>
		<div class="header am-u-md-12">
			<div class="am-g">
				<h1>发送私信</h1>
			</div>
			<hr />
		</div>
		<div class="am-g div-height">
			<div class="am-u-lg-6 am-u-md-8 am-u-sm-centered">
				<div class="am-form">
					<div class="am-g">
						<div class="am-u-sm-12">
							<input type="text" class="am-radius color" name="name" id="name"
								placeholder="搜索用户" value="" onkeyup="user_selectNameList()"
								onclick="user_selectNameList()" onblur="clearList()" autocomplete="off">
							<ul id="namelist" class="am-list am-list-border color">
							</ul>
						</div>
					</div>
					<div class="am-g">
						<div class="am-u-sm-12">
							<textarea class="am-radius" rows="12" id="mcontent"
								placeholder="私信内容"></textarea>
						</div>
					</div>
					<br> <br>
					<div class="am-g">
						<div class="am-u-sm-12">
							<button
								class="am-btn am-btn-primary am-radius am-center am-btn-lg btn-width"
								onclick="user_checkUserbIsExist()">发送</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="resources/amazeui/js/jquery-2.1.4.js"></script>
	<script src="resources/amazeui/js/amazeui.js"></script>
	<script type="text/javascript"
		src="resources/layui/lay/dest/layui.all.js"></script>
	<script type="text/javascript">
		function user_checkUserbIsExist() {
			var name = $('#name').val();
			var jsonStr = {
				name : name
			};
			$.ajax({
				type : 'GET',
				contentType : 'application/json',
				url : 'user/user_checkUserbIsExist',
				data : jsonStr,
				dataType : 'json',
				success : function(data) {
					if (data.tips == '用户存在') {
						user_doSendMessage(data.id);
					} else {
						layer.msg(data.tips);
					}
				},
				error : function(data) {
					layer.msg('服务器出错，请稍后重试');
				}
			});
		}

		function user_doSendMessage(id) {
			var mcontent = $('#mcontent').val();
			var jsonStr = {
				sendto : id,
				mcontent : mcontent,
				status : 3
			};
			$.ajax({
				type : 'GET',
				contentType : 'application/json',
				url : 'msg/user_doSendMessage',
				data : jsonStr,
				dataType : 'json',
				success : function(data) {
					layer.msg(data.tips);
				},
				error : function(data) {
					layer.msg('服务器出错，请稍后重试');
				}
			});
		}

		$(function() {
			$('#doc-my-tabs').tabs();
		});
		function user_selectNameList() {
			var name = $('#name').val();
			var list = $('#namelist');
			var suggest = "";
			var jsonStr = {
				name : name
			};
			if (name != "") {
				$
						.ajax({
							type : 'GET',
							contentType : 'application/json',
							url : 'user/user_selectNameList',
							data : jsonStr,
							dataType : 'json',
							success : function(data) {
								if (data.list != null) {
									$(data.list)
											.each(
													function(i, obj) {
														suggest += '<li><a href="javascript:void(0);" onclick="selectName(this)">'
																+ obj
																+ '</a></li>';
													});
									list.html(suggest);
								} else {
									list.html("");
								}
							},
							error : function(data) {
								layer.msg('服务器出错，请稍后重试');
							}
						});
			}
		}

		function clearList() {
			var namelist = $('#namelist');
			setTimeout(function() {
				namelist.html('');
			}, 150);
		}

		function selectName(obj) {
			$('#name').val(obj.innerHTML);
			$('#namelist').html('');
		}
	</script>
</body>
</html>
