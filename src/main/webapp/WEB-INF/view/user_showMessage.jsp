<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="czx"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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

<title></title>

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
* {
	margin: 0;
	padding: 0;
}

.img {
	width: 25px;
	height: 25px;
	border-radius: 5px 5px 5px 5px;
}

.color {
	/*   border:1px solid red; */
	
}

.content {
	float: left;
	margin-left: -10px;
}

.look {
	text-align: right;
}

.footer {
	padding-bottom: 0px;
}
.msgmargin{
    margin:0px;
    padding:0px;
}
</style>

</head>

<body>
	<div class="am-tabs " id="doc-my-tabs">
		<ul
			class="am-tabs-nav am-nav am-nav-tabs am-nav-justify am-tabs-bd-ofv">
			<li class="am-active"><a href="">赞你</a></li>
			<li><a href="">私信</a></li>
		</ul>
		<div class="am-tabs-bd">
			<div class="am-tab-panel am-active" style="margin:0px;padding:0px;" id="praiseMsg">
			
			</div>
			<div class="am-tab-panel color" style="margin:0px;padding:0px;" id="allMsg">
             
			</div>
			<div class="footer am-topbar am-topbar-fixed-bottom am-u-sm-12 color">
				<div class="write am-u-sm-12" style="height:23px;"></div>
				<div class="write am-u-sm-6 color am-fl">
					<a href="msg/user_sendMessage">写新私信</a>
				</div>
				<div class="look am-u-sm-6 color am-fr">
					<!-- <a href="javascript:void(0);" onclick="">查看全部消息</a> -->
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript"
		src="resources/amazeui/js/jquery-2.1.4.js"></script>
	<script type="text/javascript" src="resources/amazeui/js/amazeui.js"></script>
	<script type="text/javascript"
		src="resources/layui/lay/dest/layui.all.js"></script>
	<script>
		$(function() {
			$('#doc-my-tabs').tabs();
		});
		$(function() {
			showPraiseList();
			showMessageList();
		});
		
		function showPraiseList(){
			$.ajax({
				type:'GET',
				contentType:'application/json',
				url:'praise/user_showPraiseList',
				dataType:'json',
                success:function(data){
                		$.each(data.praiseList,function(item,val){
                		  if(data.praiseList[item].mark==0){
                  			if(data.praiseList[item].userb.bid!=data.userb.bid){
                           		if(data.praiseList[item].postings!=null){
                        			$('#praiseMsg').append(
                       					 '<div class="am-u-sm-12 am-panel am-panel-default msgmargin" data-am-alert >'
                       				    +' <a href="#"><img src="'+data.praiseList[item].userb.img+'" class="img" /> '+data.praiseList[item].userb.name+' </a>'
                       				    +'<button type="button" class="am-close am-fr" style="color:red;" onclick="user_ClosePraise('+data.praiseList[item].sid+')">&times;</button>'
        	               				+'  <p id="praise'+data.praiseList[item].sid+'"> 赞了你的帖子，'+data.praiseList[item].postings.title+'</p>'
        	               				+'   <button type="button" class="am-btn am-btn-primary am-btn-xs am-radius" onclick="user_selectFriend('+data.praiseList[item].userb.bid+')">添加好友</button> '
        	               				+'  <button type="button" class="am-btn am-btn-success am-btn-xs am-radius" onclick="user_replyTo('+data.praiseList[item].userb.bid+')">私信他</button>'
        	               				+'   <p class="am-fr" style="margin-top:10px;">'+new Date(data.praiseList[item].pushtime).toLocaleDateString()+'</p>'
        	               				+' </div>'
                                	);
                        			$.each(data.praiseList[item].friend,function(i,v){
                        				if((data.userb.bid==data.praiseList[item].friend[i].userf.bid)||(data.praiseList[item].userb.bid==data.praiseList[item].friend[i].userf.bid)){
	                                       $('#praise'+data.praiseList[item].sid).next().remove();
                        				}
                        			});
                                }else if(data.praiseList[item].details!=null){
                                	$('#praiseMsg').append(
                                	 '<div class="am-u-sm-12 am-panel am-panel-default msgmargin" data-am-alert >'
                   				    +' <a href="#"><img src="'+data.praiseList[item].userb.img+'" class="img" /> '+data.praiseList[item].userb.name+' </a>'
                   				    +'<button type="button" class="am-close am-fr" style="color:red;" onclick="user_ClosePraise('+data.praiseList[item].sid+')">&times;</button>'
                       				+'  <p> 赞了你的回答</p>'
                       				+'   <button type="button" class="am-btn am-btn-primary am-btn-xs am-radius" onclick="user_selectFriend('+data.praiseList[item].userb.bid+')">添加好友</button> '
                       				+'  <button type="button" class="am-btn am-btn-success am-btn-xs am-radius" onclick="user_replyTo('+data.praiseList[item].userb.bid+')">私信他</button>'
                       				+'   <p class="am-fr" style="margin-top:10px;">'+new Date(data.praiseList[item].pushtime).toLocaleDateString()+'</p>'
                       				+' </div>'
                       				);
                        			$.each(data.praiseList[item].friend,function(i,v){
                        				if((data.userb.bid==data.praiseList[item].friend[i].userf.bid)||(data.praiseList[item].userb.bid==data.praiseList[item].friend[i].userf.bid)){
	                                       $('#praise'+data.praiseList[item].sid).next().remove();
                        				}
                        			});
                                }else if(data.praiseList[item].comments!=null){
                                	$('#praiseMsg').append(
                                	 '<div class="am-u-sm-12 am-panel am-panel-default msgmargin" data-am-alert >'
                   				    +' <a href="#"><img src="'+data.praiseList[item].userb.img+'" class="img" /> '+data.praiseList[item].userb.name+' </a>'
                   				    +'<button type="button" class="am-close am-fr" style="color:red;" onclick="user_ClosePraise('+data.praiseList[item].sid+')">&times;</button>'
                       				+'  <p> 赞了你的评论</p>'
                       				+'   <button type="button" class="am-btn am-btn-primary am-btn-xs am-radius" onclick="user_selectFriend('+data.praiseList[item].userb.bid+')">添加好友</button> '
                       				+'  <button type="button" class="am-btn am-btn-success am-btn-xs am-radius" onclick="user_replyTo('+data.praiseList[item].userb.bid+')">私信他</button>'
                       				+'   <p class="am-fr" style="margin-top:10px;">'+new Date(data.praiseList[item].pushtime).toLocaleDateString()+'</p>'
                       				+' </div>'
                       				);
                        			$.each(data.praiseList[item].friend,function(i,v){
                        				if((data.userb.bid==data.praiseList[item].friend[i].userf.bid)||(data.praiseList[item].userb.bid==data.praiseList[item].friend[i].userf.bid)){
	                                       $('#praise'+data.praiseList[item].sid).next().remove();
                        				}
                        			});
                                }
                			} 
                		  }	
                    	});
                },
                error:function(data){
                	layer.msg('服务器出错，请稍后重试',{offset: '50%'});
                }
			});
		}
		
		function showMessageList(){
			$.ajax({
				type:'GET',
				contentType:'application/json',
				url:'msg/user_showMessageList',
				dataType:'json',
                success:function(data){
                	if(data.messageList!=null){
                		$.each(data.messageList,function(item,val){
                    		if(data.messageList[item].status==0){
                    			$('#allMsg').append(
               				     '<div class="am-u-sm-12 am-panel am-panel-default msgmargin" id="msg'+data.messageList[item].mid+'" data-am-alert >'
                    		  	  +'<a href="#"><img src="'+data.messageList[item].userb.img+'" class="img" />'+data.messageList[item].userb.name +'</a>'
                    			  +'  <button type="button" class="am-close am-fr" style="color:red;" onclick="user_closeMsg('+data.messageList[item].mid+')">&times;</button>'
                    			  +'  <p> 申请添加你为好友，验证信息为：'+data.messageList[item].mcontent+'</p>'
                    			  +'  <button type="button" class="am-btn am-btn-default am-btn-xs am-radius" disabled="disabled"> 已拒绝对方的好友申请 </button>'
                    			  +'  <p class="am-fr" style="margin-top:10px;">'+new Date(data.messageList[item].senddate).toLocaleDateString()+'</p>'
                    			  +'</div>'
                        		);	 	
                    			
                    		}else if(data.messageList[item].status==1){
                    			$('#allMsg').append(
                  				  '<div class="am-u-sm-12 am-panel am-panel-default msgmargin" data-am-alert >'
                       		  	  +'<a href="#"><img src="'+data.messageList[item].userb.img+'" class="img" />'+data.messageList[item].userb.name +'</a>'
                       			  +'  <button type="button" class="am-close am-fr" style="color:red;" onclick="user_closeMsg('+data.messageList[item].mid+')">&times;</button>'
                       			  +'  <p> 申请添加你为好友，验证信息为：'+data.messageList[item].mcontent+'</p>'
                       			  +'  <button type="button" class="am-btn am-btn-default am-btn-xs am-radius" disabled="disabled"> 已同意对方的好友申请 </button>'
                       			  +'  <p class="am-fr" style="margin-top:10px;">'+new Date(data.messageList[item].senddate).toLocaleDateString()+'</p>'
                       			  +'</div>'
                           		);	 	
                    		}else if(data.messageList[item].status==2){
                    			$('#allMsg').append(
                 			    '<div class="am-u-sm-12 am-panel am-panel-default msgmargin"  data-am-alert>'
                 			    +'<a href="#" ><img src="'+data.messageList[item].userb.img+'" class="img" />'+data.messageList[item].userb.name +' </a>'
                 				+'<button type="button" class="am-close am-fr" style="color:red;" onclick="user_closeMsg('+data.messageList[item].mid+')">&times;</button>'
    	             			+'<p id="msg'+data.messageList[item].mid+'">申请添加你为好友，验证信息为：'+data.messageList[item].mcontent+' </p>'
    	             			+'<button type="button" class="am-btn am-btn-success am-btn-xs am-radius" onclick="user_agreeOrNotAddFriend('+data.messageList[item].mid+','+data.messageList[item].userb.bid+',1)">同意</button> '
    	             			+' <button type="button" class="am-btn am-btn-danger am-btn-xs am-radius" onclick="user_agreeOrNotAddFriend('+data.messageList[item].mid+','+data.messageList[item].userb.bid+',0)">拒绝</button>'
    	             			+'<p class="am-fr" style="margin-top:10px;">'+new Date(data.messageList[item].senddate).toLocaleDateString()+'</p>'
    	             			+' </div>'
    	             			);
                    		}else if(data.messageList[item].status==3){
                        		$('#allMsg').append(
                  				   '<div class="am-u-sm-12 am-panel am-panel-default msgmargin" data-am-alert >'
                       			  +'<a href="#"><img src="'+data.messageList[item].userb.img+'" class="img" /> '+data.messageList[item].userb.name +' </a>'
                       			  +'  <button type="button" class="am-close am-fr" style="color:red;" onclick="user_closeMsg('+data.messageList[item].mid+')">&times;</button>'
                       			  +'  <p id="status'+data.messageList[item].mid+'"> '+data.messageList[item].mcontent+'</p>'
                       			  +'  <button type="button" class="am-btn am-btn-primary am-btn-xs am-radius" onclick="user_selectFriend('+data.messageList[item].userb.bid+')">添加好友</button>'
                       			  +'  <button type="button" class="am-btn am-btn-success am-btn-xs am-radius" onclick="user_replyTo('+data.messageList[item].bid+')">回复</button>'
                       			  +'  <p class="am-fr" style="margin-top:10px;">'+new Date(data.messageList[item].senddate).toLocaleDateString()+'</p>'
                       			  +'</div>'
                           		);	
                        		$('#status'+data.messageList[item].mid).next().remove();
                    		}else if(data.messageList[item].status==4){
                    			$('#allMsg').append(
                  				  '<div class="am-u-sm-12 am-panel am-panel-default msgmargin" data-am-alert >'
                       		  	  +'<a href="#"><img src="'+data.messageList[item].userb.img+'" class="img" />'+data.messageList[item].userb.name +'</a>'
                       			  +'  <button type="button" class="am-close am-fr" style="color:red;" onclick="user_closeMsg('+data.messageList[item].mid+')">&times;</button>'
                       			  +'  <p> '+data.messageList[item].mcontent+'</p>'
                       			  +'  <p class="am-fr" style="margin-top:10px;">'+new Date(data.messageList[item].senddate).toLocaleDateString()+'</p>'
                       			  +'</div>'
                           		);
                    		}
                    	});
                	}
                },
                error:function(data){
                	layer.msg('服务器出错，请稍后重试',{offset: '50%'});
                }
			});
		}
		
		function user_sendMessage() {
			layer.open({
				type : 2,
				title : '发送私信',
				shadeClose : true,
				shade : 0.8,
				area : [ '300px', '450px' ],
				offset : '35px',
				moveOut : true,
				content : [ 'msg/user_sendMessage', 'no' ], //iframe的url，no代表不显示滚动条
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
		
		function user_agreeOrNotAddFriend(mid,id,status){
		    var jsonStr = {
		    	mid : mid,	
				status : status
			};
			$.ajax({
				type : 'GET',
				contentType : 'application/json',
				url : 'msg/user_agreeOrNotAddFriend',
				data : jsonStr,
				dataType : 'json',
				success : function(data) {
					user_insertFriend(id);
					user_addOrNotSendMessage(id,status);
					var p=$('#msg'+mid);
					p.next().remove();
					p.next().remove();
					if(status==0){
					  p.next().after('<button type="button" class="am-btn am-btn-default am-btn-xs am-radius" disabled="disabled"> 已拒绝对方的好友申请 </button>');
					}else if(status==1){
					  p.next().after('  <button type="button" class="am-btn am-btn-default am-btn-xs am-radius" disabled="disabled"> 已同意对方的好友申请 </button>');	
					}
				},
				error : function(data) {
					layer.msg('服务器出错，请稍后重试',{offset: '50%'});
				}
			});
		}
		
		function user_insertFriend(id) {
			var jsonStr1 = {
				'userf.bid' : id
			};
			$.ajax({
				type : 'GET',
				contentType : 'application/json',
				url : 'friend/user_insertFriend',
				data : jsonStr1,
				dataType : 'json',
				success : function(data) {
				},
				error : function(data) {
					layer.msg('服务器出错，请稍后重试',{offset: '50%'});
				}
			});
		}
		
		function user_addOrNotSendMessage(sendto,status){
			 var mcontent='';
			 if(status==0){
				 mcontent='对方拒绝了你的好友申请';
			 }else if(status==1){
				 mcontent='对方同意了你的好友申请';
			 }
			 var jsonStr = {
					mcontent : mcontent, 
					sendto : sendto, 
					status : 4
				};
				$.ajax({
					type : 'GET',
					contentType : 'application/json',
					url : 'msg/user_doSendMessage',
					data : jsonStr,
					dataType : 'json',
					success : function(data) {
					},
					error : function(data) {
						layer.msg('服务器出错，请稍后重试',{offset: '50%'});
					}
				});
		}
		
		function user_replyTo(id){
			layer.prompt({
				title : '回复',
				formType : 2,
				offset : '175px',
				area : [ '300px', '120px' ],
			}, function(data, index) {
				layer.close(index);
				var jsonStr = {
                    mcontent : data,
                    sendto : id,
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
		
		function user_closeMsg(mid){
			var jsonStr = {
               mid : mid
			};
			$.ajax({
				type : 'GET',
				contentType : 'application/json',
				url : 'msg/user_closeMsg',
				data : jsonStr,
				dataType : 'json',
				success : function(data) {
				},
				error : function(data) {
					layer.msg('服务器出错，请稍后重试',{offset: '50%'});
				}
			});
		}
		
		function user_ClosePraise(sid){
			var jsonStr = {
               sid : sid
			};
			$.ajax({
				type : 'GET',
				contentType : 'application/json',
				url : 'praise/user_closePraise',
				data : jsonStr,
				dataType : 'json',
				success : function(data) {
				},
				error : function(data) {
					layer.msg('服务器出错，请稍后重试',{offset: '50%'});
				}
			});
		}
	</script>
</body>
</html>

