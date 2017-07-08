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

<title>好友管理</title>

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
	margin-top: 20px;
}

.header p {
	font-size: 14px;
}

#content {
	float: right;
}

#insertFriend {
	margin-left: 5%;
}
.img{
  width:30px;
  height:30px;
}

.trends{
  margin:0px;
  paddding:0px;
}
</style>

</head>

<body>
	<div class="header">
		<hr />
	</div>
	<div class="am-g" id="content">
		<button type="button" class="am-btn am-btn-primary am-radius" id="insertFriend"
			onclick="user_checkUserbIsExist()">添加好友</button>
		<div class="am-u-lg-11 am-u-md-8 am-u-sm-centered">
			<hr>
			<div class="am-g">
				<div class="am-u-sm-12">
				 <div class="am-u-sm-8" style="height:450px;border-right: 1px solid #D0D0D0;">
				 <span class="am-badge am-badge-success am-radius" id="left">好友动态</span>
				 </div>	 
				 <div class="am-u-sm-4" id="right">
				     <ul id="demo"></ul>
 					<table class="am-table am-table-bd am-table-striped admin-content-table">
						<thead>
							<tr>
								<th>头像</th>
								<th>用户名</th>
								<th>备注</th>
								<th>管理</th>
							</tr>
						</thead>
						<tbody id="friend">
						</tbody>
					</table>
				  </div>	
				</div>
			</div>

			<div class="am-g">
				<div class="am-u-md-6"></div>
				<hr>
				<p>© 2016 daidaizhizuo</p>
			</div>
		</div>
	<script type="text/javascript"
			src="resources/amazeui/js/jquery-2.1.4.js"></script>
		<script type="text/javascript" src="resources/amazeui/js/amazeui.js"></script>
		<script type="text/javascript"
			src="resources/layui/lay/dest/layui.all.js"></script>
		<script type="text/javascript">
			$(function() {
				selectFriendList();
				user_selectFriendTrendsList();
			});
		    
			function selectFriendList(){
				$.ajax({
					type : 'GET',
					contentType : 'application/json',
					url : 'friend/user_selectFriendList',
					data : '',
					dataType : 'json',
					success : function(data){
						if(data.tips=='获取成功'){
						 $.each(data.friendList,function(item,val){	
                           $('#friend').append(
                            '<tr id="friend'+val.fid+'">'
   							+'<td><img alt="头像" src="'+val.userf.img+'" class="img"></td>'
   							+'<td>'+val.userf.name+'</td>'
   							+'<td>'+val.remark+'</td>'
   							+'<td>'
   							+'<div class="am-dropdown am-dropdown-flip" data-am-dropdown>'
   							+'<button class="am-btn am-btn-default am-btn-xs am-dropdown-toggle" data-am-dropdown-toggle>'
   							+'<span class="am-icon-cog"></span> <span class="am-icon-caret-down"></span>'
   							+'</button>'
   							+'<ul class="am-dropdown-content am-radius">'
   							+'<li><a href="javascript:void(0);"  onclick="user_doSendMessage('+val.userf.bid+')">发送消息</a></li>'
   							+'<li><a href="javascript:void(0);" onclick="user_updateFriend('+val.fid+')">修改备注</a></li>'
   							+'<li><a href="javascript:void(0);" onclick="user_deleteFriend('+val.fid+','+val.userf.bid+')">删除</a></li>'
   							+'</ul>'
   							+'</div>'
   							+'</td>'
   							+'</tr>'   
                           );
						 });
						 loadJs();
						}else{
							layer.msg(data.tips,{offset: '50%'});
						}
					},
					error : function(data){
						layer.msg('服务器出错，请稍后重试',{offset: '50%'});
					}
				});
			}
			
			 //重新加载amazeui的js文件，使得通过ajax动态获取的html里的方法能够点击
			 function loadJs() {
		            var head = $("head").remove("script[src='resources/amazeui/js/amazeui.js']");
		            $("<scri" + "pt>" + "</scr" + "ipt>").attr({ role: 'reload', src: "resources/amazeui/js/amazeui.js", type: 'text/javascript' }).appendTo(head);
		     }
			 
			function user_selectFriendTrendsList(){
				$.ajax({
					type : 'GET',
					contentType : 'application/json',
					url : 'friend/user_selectFriendTrendsList',
					dataType : 'json',
					success : function(data) {
						 $.each(data.list,function(item,val){
							$('#left').after(
							   '<div >'
							   +'<p class="trends">'+new Date(val.publishtime).toLocaleDateString()+'</p>'
							   +'<hr class="trends"/>'
							   +'<p ><img src="'+val.userb.img+'" class="img am-radius"/> '+val.userb.name+' 发表了帖子<a href="javascript:void(0);" onclick="skip('+val.pid+')"> '+val.title +'</a> '+val.praisenum +'赞  '+val.replynum +'评论</p>'
							   +'</div>'
							);
						 });
					},
					error : function(data) {
						layer.msg('服务器出错，请稍后重试',{offset: '50%'});
					}
				});
			}
			
			function skip(pid){
				window.parent.location.href = 'user_postings.jsp?pid='+pid;
			}
			
			function user_checkUserbIsExist() {
				layer.prompt({
					title : '输入对方用户名'
				}, function(name, index) {
					layer.close(index);
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
								user_selectFriend(data.id);
							} else {
								layer.msg(data.tips,{offset: '50%'});
							}
						},
						error : function(data) {
							layer.msg('服务器出错，请稍后重试',{offset: '50%'});
						}
					});

				});
			}

			function user_selectFriend(id){
				var jsonStr = {
					'userf.bid' : id	
				};
				
				$.ajax({
					type : 'GET',
					contentType : 'application/json',
					url : 'friend/user_selectFriend',
					data : jsonStr,
					dataType : 'json',
					success : function(data){
						if(data.tips=='可以添加'){
							user_applyForFriend(id);
						}else{
							layer.msg(data.tips,{offset: '50%'});
						}
					},
					error : function(data){
						layer.msg('服务器出错，请稍后重试',{offset: '50%'});
					}
				});
			}
			
			function user_applyForFriend(id){
				layer.prompt({
					title : '验证信息',
					formType : 2,
					offset : '175px',
					area : [ '300px', '120px' ],
				}, function(data, index) {
					layer.close(index);
					var jsonStr = {
	                    mcontent : data,
	                    sendto : id,
	                    status : 2
					};
					$.ajax({
						type : 'GET',
						contentType : 'application/json',
						url : 'msg/user_doSendMessage',
						data : jsonStr,
						dataType : 'json',
						success : function(data) {
							layer.msg(data.tips,{offset: '50%'});
						},
						error : function(data) {
							layer.msg('服务器出错，请稍后重试',{offset: '50%'});
						}
					});
				});
			}
			
			function user_doSendMessage(id) {
				layer.prompt({
					title : '发私信',
					formType : 2,
					offset : '145px',
					area : [ '350px', '140px' ],
				}, function(data, index) {
					layer.close(index);
					var jsonStr = {
						sendto : id,
						mcontent : data,
						status : 3
					};
					$.ajax({
						type : 'GET',
						contentType : 'application/json',
						url : 'msg/user_doSendMessage',
						data : jsonStr,
						dataType : 'json',
						success : function(data) {
							layer.msg(data.tips,{offset: '50%'});
						},
						error : function(data) {
							layer.msg('服务器出错，请稍后重试',{offset: '50%'});
						}
					});
				});
			}
			
			function user_deleteFriend(fid,id){
				layer.confirm('是否删除？', {
				   btn: ['确定','取消'] //按钮
				 }, function(){
					var jsonStr = {
						'userf.bid' : id	
					};
					$.ajax({
					  type : 'GET',
					  contentType : 'application/json',
					  url : 'friend/user_deleteFriend',
					  data : jsonStr,
					  dataType : 'json',
					  success : function (data){
						  $('#friend'+fid).remove();
						  layer.msg(data.tips,{offset: '50%'});
					  },
					  error : function (data){
						  layer.msg('服务器出错，请稍后重试',{offset: '50%'});
					  }
					});
				 }, function(index){
					layer.close(index);
				});
			}
			
			function user_updateFriend(id){
				layer.prompt({
					title : '修改备注',
					formType : 2,
					offset : '145px',
					area : [ '270px', '30px' ],
				}, function(data, index) {
					layer.close(index);
					var content = data;
					var jsonStr = {
						fid : id,	
						remark : data
					};
					$.ajax({
						type : 'GET',
						contentType : 'application/json',
						url : 'friend/user_updateFriend',
						data : jsonStr,
						dataType : 'json',
						success : function(data1) {
							$('#friend'+id).children(':eq(2)').text(content);
							layer.msg(data1.tips,{offset: '50%'});
						},
						error : function(data) {
							layer.msg('服务器出错，请稍后重试',{offset: '50%'});
						}
					});
				});
			}
			
// 			function selectFriendList(){
// 				$.ajax({
// 					type : 'GET',
// 					contentType : 'application/json',
// 					url : 'friend/user_selectFriendList',
// 					dataType : 'json',
// 					success : function (data){
// 						str = data.nameList;
// 						if(data.friendList==null){
// 							$('#demo').html('无好友');
// 						}else{
// 	   					    layui.tree({
// 	  						  elem: '#demo' //传入元素选择器
// 	  						  ,nodes: data.nameList
// 	  							  [{'name':'崔志翔'},{'name':'崔志翔'}]
// 	  						});
// 						}
// 					},
// 					error : function(data){
// 						layer.msg('服务器出错，请稍后重试');
// 					}
// 				});
// 			}
		</script>
</body>
	
</html>
