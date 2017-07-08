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

<title>提问</title>

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
	/*   border:1px solid red; */
	
}

.descript {
	margin: 5px;
}

p {
	color: gray;
}

.btn-width {
	width: 40%;
}
</style>

</head>

<body>
	<div class="header am-u-md-12">
		<div class="am-g">
			<h1>写下你的问题</h1>
			<p>描述精确的问题更易得到解答</p>
		</div>

		<hr />
	</div>
	<div class="am-g">
		<div class="am-u-lg-6 am-u-md-8 am-u-sm-centered color">
			<div class="am-form">
				<div class="am-g">
					<div class="am-u-sm-12">
						<input type="text" class="am-radius color" name="title" id="title"
							placeholder="问题标题" value=""> <br>
					</div>
				</div>
				<div class="am-g">
					<div class="am-u-sm-12">
						<input type="text" class="am-radius color" name="tname" id="tname"
							placeholder="添加话题" value="">
					</div>
				</div>
				<div class="am-g">
					<div class="am-u-sm-11 descript color">问题描述（可选）：</div>
				</div>
				<div class="am-g">
					<div class="am-u-sm-12">
					<textarea id="pcontent" style="height:250px;" class="am-radius"></textarea>
<!-- 						<textarea id="pcontent" style="display: none;"></textarea> -->
					</div>
				</div>
				<br>
				<div class="am-g">
					<div class="am-u-sm-12">
						<button
							class="am-btn am-btn-primary am-radius am-center am-btn-lg btn-width" id="commitQuestion" onclick="insertPostings()">
							提交问题</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript"
		src="resources/amazeui/js/jquery-2.1.4.js"></script>
	<script type="text/javascript" src="resources/amazeui/js/amazeui.js"></script>
		<script type="text/javascript"
		src="resources/layui/lay/dest/layui.all.js"></script>
<!-- 	<script type="text/javascript" src="resources/layui/layui.js"></script> -->
	<script type="text/javascript">
// 		layui.use('layedit', function() {
// 			var layedit = layui.layedit;
// 			layedit.set({
// 				uploadImage : {
// 					url : 'resources/upload/' //接口url
// 					,
// 					type : 'post' //默认post
// 				},
// 				height:200,
// 				hideTool:['face']
// 			});
// 			layedit.build('pcontent'); //建立编辑器
// 		});
		
		function insertPostings(){
			var title = $('#title').val();
			var pcontent = $('#pcontent').val();
			var tname = $('#tname').val();
			var jsonStr = {
					title : title,
                    pcontent : pcontent,
                    'postings_theme[0].theme.tname' :tname
				};
			$.ajax({
				type : 'GET',
				contentType : 'application/json',
				url : 'postings/user_insertPostings',
				data : jsonStr,
				dataType : 'json',
				success : function(data) {
					layer.msg(data.tips);
					if(data.tips=='问题发布成功'){
						parent.location.href = 'user_postings.jsp?pid='+data.pid;
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
