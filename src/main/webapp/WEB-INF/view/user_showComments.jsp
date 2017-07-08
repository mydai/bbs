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
.img {
	width: 30px;
	height: 30px;
}
#first{
  margin-top:5px;
}
.textarea-dai{
  margin:2px 0 2px 0;
}
.comment-dai{
  margin:7px 0 0 12px;
}
.replytime{
  margin-bottom:10px;
}
.icon {
	color: gray;
	font-size: 16px;
}
.icon-margin {
	margin-left: 10px;
}
</style>

</head>

<body>
    <input value="${requestScope.ddid } " id="did" hidden/>
    <hr>
    <div class="am-u-md-12" id="first">
    </div>
    <div>&nbsp;</div>
    <div class="footer am-topbar am-topbar-fixed-bottom am-u-sm-12 color">
		<textarea rows="2" cols="68" class="textarea-dai" id="ccontent"></textarea>
		<button class="am-btn am-btn-primary am-btn-xl am-radius comment-dai" onclick="insertComments()">评论</button>
	</div>
	<script type="text/javascript"
		src="resources/amazeui/js/jquery-2.1.4.js"></script>
	<script type="text/javascript" src="resources/amazeui/js/amazeui.js"></script>
	<script type="text/javascript"
		src="resources/layui/lay/dest/layui.all.js"></script>
	<script type="text/javascript">
		$(function() {
			user_selectCommentsList();
		});
		
		function user_selectCommentsList(){
			var did = $('#did').val();
			var jsonStr = {
                did:did
			};
			$.ajax({
				type : 'GET',
				contentType : 'application/json',
				url : 'comments/user_selectCommentsList',
				data : jsonStr,
				dataType : 'json',
				success : function(data) {
					if(data.tips=='获取成功'){
						var first = $('#first');
						$.each(data.commentsList,function(item,val){
							first.append(
							   	'<div class="comments"><img src="'+data.commentsList[item].userb.img+'" class="img am-radius"/><b> '
							   	+data.commentsList[item].userb.name+' ： </b>'
							   	+'<span>'+data.commentsList[item].ccontent+'</span></div>'
             					+ '<a href="javascript:void(0);" class="am-fr" onclick="user_reportComments('+data.commentsList[item].cid+')"><span class="am-icon-bomb color icon icon-margin"> 举 报</span></a>'
							   	+'<div class="am-fr replytime">'+new Date(data.commentsList[item].replytime).toLocaleDateString()+'</div>'
							   	+'<hr/>'	
							);
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
		function insertComments(){
			var did = $('#did').val();
			var ccontent = $('#ccontent').val();
			var jsonStr = {
				   did:did,
	               ccontent:ccontent
				};
				$.ajax({
					type : 'GET',
					contentType : 'application/json',
					url : 'comments/user_insertComments',
					data : jsonStr,
					dataType : 'json',
					success : function(data) {
						layer.msg(data.tips);
						if(data.tips=='评论成功'){
							location.reload();
						}
					},
					error : function(data) {
						layer.msg('服务器出错，请稍后重试');
					}
				});
		}
		function user_reportComments(cid) {
			layer.prompt({
				title : '举报',
				formType : 2,
				offset : '175px',
				moveOut : true,
				area : [ '370px', '180px' ],
			}, function(data, index) {
				layer.close(index);
				var jsonStr = {
                    rcontent : data,
                    cid : cid
				};
				$.ajax({
					type : 'GET',
					contentType : 'application/json',
					url : 'report/user_sendReport',
					data : jsonStr,
					dataType : 'json',
					success : function(data) {
						layer.msg(data.tips);
					},
					error : function(data) {
						layer.msg('服务器出错，请稍后重试');
					}
				});
			});
		}
	</script>
</body>
</html>
