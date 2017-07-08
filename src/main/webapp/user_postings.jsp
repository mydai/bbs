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

<title>短信息论坛</title>

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
@media only screen and (min-width: 1200px) {
	.blog-g-fixed {
		max-width: 1200px;
	}
}

@media only screen and (min-width: 641px) {
	.blog-sidebar {
		font-size: 1.4rem;
	}
}

.blog-main {
	padding: 20px 0;
}

.blog-title {
	margin: 10px 0 20px 0;
}

.blog-meta {
	font-size: 14px;
	margin: 10px 0 20px 0;
	color: #222;
}

.blog-meta a {
	color: #27ae60;
}

.blog-pagination a {
	font-size: 1.4rem;
}

.blog-team li {
	padding: 4px;
}

.blog-team img {
	margin-bottom: 0;
}

.blog-content img,.blog-team img {
	max-width: 100%;
	height: auto;
}

.blog-footer {
	padding: 10px 0;
	text-align: center;
}

.search_top {
	width: 223px;
}

#search {
	width: 100%;
}

#lastli {
	width: 100px;
}

.left {
	float: left;
	/* 	border: 1px solid red; */
	width: 50px;
	margin-left: 13px;
}

.right {
	float: left;
	/* 	border: 1px solid red; */
}

.title {
	color: gray;
	font-size: 14px;
	padding: 0px;
	/* 	border: 1px solid red; */
}

.content {
	color: black;
	padding: 0px;
	font-size: 13px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.color {
/* 	border: 1px solid red; */
}

.marginset {
	margin: 0px;
}

.img {
	width: 35px;
	height: 35px;
}
.img-lg{
   	width: 55px;
	height: 55px;
}

.acticle {
	float: left;
	margin-top: 0px;
	padding-top: 0px;
}

.ask {
	margin-left: 40px;
}

.margin-left {
	margin-left: 200px;
}

.icon {
	font-size: 12px;
}

.icon-margin {
	margin-left: 10px;
}
.margin-top {
	margin-top: 30px;
}
.margin-details{
	margin-top: 15px;
    margin-bottom: 15px;
}
li {
	list-style: none;
}

.avg {
	margin: 0px 0px 3px 0px;
	padding: 0px;
}

.li-width {
	width: 5px;
}

.content-font-size {
	font-size: 14px;
}

.inline {
	display: inline;
}
.details-hidden{
    display : none;
}
.clickpraise{
}
#titleList{
  margin-top:0px;
  position: absolute;
  width:300px;
}
</style>

</head>

<body>
	<header class="am-topbar am-topbar-fixed-top">
	<h1 class="am-topbar-brand">
		<b>短信息论坛</b>
	</h1>
	<button
		class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only"
		data-am-collapse="{target: '#doc-topbar-collapse'}">
		<span class="am-sr-only">导航切换</span> <span class="am-icon-bars"></span>
	</button>
	<div class="am-collapse am-topbar-collapse" id="doc-topbar-collapse">
		<ul class="am-nav am-nav-pills am-topbar-nav">
			<li ><a href="#">首页</a></li>
			<li class="am-active"><a>帖子</a></li>
			<li id="lastli"></li>
		</ul>
        <form class="am-topbar-form am-topbar-left am-form-inline am-topbar-center"
			role="search">
			<div class="am-form-group am-input-group-sm ">
			<input id="searchpid" hidden value="">
			<input type="text" class="am-form-field am-radius" name="title" 
			id="title" placeholder="搜索你感兴趣的内容.." onkeyup="user_selectTitleList()"
		    onclick="user_selectTitleList()" onblur="clearList()" autocomplete="off" style="width:300px;" onkeydown="if(event.keyCode == 13)user_searchPostings()">
        	<a href="javascript:void(0);" onclick="user_searchPostings()"><span class="am-icon-search"></span></a>
		    <ul id="titleList" class="am-list am-list-border"></ul>
			</div>

			<b class="ask"></b>
			<czx:if test="${sessionScope.curr_user!=null}">
				<button type="button"
					class="am-btn am-btn-primary am-btn-sm am-radius "
					onclick="user_askQuestion()">提问</button>
				<b style="margin-left:105px;"></b>
				<button type="button"
					class="am-btn am-btn-default am-btn-sm am-radius "
					onclick="user_showMessage()"><span class="am-icon-bell-o"> <span class="am-badge am-badge-danger am-round" id="msgCount"></span></span></button>
			</czx:if>
			<czx:if test="${sessionScope.curr_user==null}">
				<button type="button"
					class="am-btn am-btn-success am-btn-sm am-radius btn-right margin-left"
					onclick="user_login()">登录</button>
			</czx:if>
			<czx:if test="${sessionScope.curr_user!=null}">
				<b style="margin-left:45px;"></b>
				<div class="am-dropdown color margin-left avg" data-am-dropdown>
					<b><a href="#" class="am-btn am-dropdown-toggle avg"
						data-am-dropdown-toggle><img
							src="${sessionScope.curr_user.img } " class="img am-radius" /></a></b>
					<ul class="am-dropdown-content color "
						style="width:10px;margin:0px;padding:0px;">
						<li class="am-dropdown-header">用户：<b style="font-size:20px;">${sessionScope.curr_user.name }</b></li>
						<li class="am-divider"></li>
						<li><a href="user/user_center">个人中心</a></li>
						<li class="am-divider"></li>
						<li><a href="user/user_logOff">注销</a></li>
					</ul>
				</div>
			</czx:if>
		</form>
	</div>
	</header>
	<div class="am-g am-g-fixed blog-g-fixed margin-top">
		<div class="am-u-md-1 color" style="margin-top: 0px;">
			<div data-am-sticky="{top:400}" class="am-radius">
				<div data-am-widget="gotop"
					class="am-gotop am-gotop-default am-radius">
					<a href="#top" title="回到顶部" class="am-radius"
						data-am-popover="{content: '回到顶部', trigger: 'hover focus'}"> <span
						class="am-icon-arrow-up "></span>
					</a>
				</div>
			</div>
		</div>
		<div class="am-u-md-7 color" id="first">
			
		</div>
		<div class="am-u-md-3 am-u-end color blog-sidebar" id="fourth">
			
		</div>
	</div>
	<footer class="blog-footer">
	<p>
		<br /> <small>© Copyright daidaizhizuo </small>
	</p>
	</footer>
	<!--[if lt IE 9]>
	<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
	<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
	<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
	<![endif]-->

	<!--[if (gte IE 9)|!(IE)]><!-->
	<script src="resources/amazeui/js/jquery-2.1.4.js"></script>
	<!--<![endif]-->
	<script src="resources/amazeui/js/amazeui.js"></script>
	<script type="text/javascript"
		src="resources/layui/lay/dest/layui.all.js"></script>
	<script type="text/javascript">
    	function share(){
    	   layer.msg('二维码a',{offset: '50%'});
		   var condition = {
			  text: 'localhost:8080/ssm/user_postings.jsp?pid=1', // 要生产二维码的文字
			  width: 115, // 二维码宽度 `px`
			  height: 115, // 二维码高度 `px`
			  correctLevel: 3, // 纠错级别，可取 0、1、2、3，数字越大说明所需纠错级别越大
			  background: "#ffffff", // 背景色
			  foreground: "#000000" // 前景色
			};
         var qr = $('.doc-qrcode');
			function makeCode() {
				qr.empty().qrcode(condition);
			}
			makeCode();
		}
 
		$(function() {
			user_postings();
		});

		function user_postings(){
			var pid = ${param.pid};
			var first = $('#first');
			var jsonStr = {
				pid : pid
			};
			$.ajax({
				type : 'GET',
				contentType : 'application/json',
				url : 'postings/user_selectPostings',
				data : jsonStr,
				dataType : 'json',
				success : function(data) {
					if(data.userb!=null){
				 	   setInterval ("getMsgCount()", 5000);
					}
					if(data.tips=='该帖不存在'){
						layer.confirm(data.tips, {
							  btn: ['确定'] //按钮
							}, function(){
								self.location='#'; 
							});
					}else if(data.tips=='获取成功'){
						first.append('<div>'
								+ '<div class="inline" id="theme">'
								
								+ '</div>'
								+ '<h2 class="color marginset">'
								+ data.postings.title
								+ '</h2>'
								+ '<div class="am-article-hd">'
								+ data.postings.pcontent
								+ '</div>'
								+ '<p class="inline title">编辑于'
								+ new Date(data.postings.publishtime).toLocaleDateString()
								+ '</p>'
								+ '<a href="javascript:void(0);" onclick="user_clickPostingsPraise()"><span class="am-icon-thumbs-up color icon icon-margin"> 点 赞</span></a>'
								+ '<a href="javascript:void(0);" onclick="moveToDcontent()"><span class="am-icon-comment color icon icon-margin"> 回 答</span></a>'
								+ '<a href="#"><span class="am-icon-share color icon icon-margin"> 分 享</span></a>'
								
								+ '<a href="#"><span class="am-icon-bookmark color icon icon-margin">收 藏</span></a>'
								+ '<a href="javascript:void(0);" onclick="user_reportPostings()"><span class="am-icon-bomb color icon icon-margin"> 举 报</span></a>'
								+ '<hr />'
								+ '<b id="praisenum">'
								+ data.postings.praisenum
								+ '</b> 人赞同 '
								+ ' <b id="replynum">'
								+ data.postings.details.length
								+ '</b> 个回答'
								+ '<div id="second">'
								+ '</div>'
								+ '<div id="third">'
								+ '</div>'
								+ '</div>');
						 if(data.userb!=null){
                            if(data.postings.praise!=null){
                         	   $.each(data.postings.praise,function(i,val){
								 if((data.postings.praise[i].status==1)&&(data.userb.bid==data.postings.praise[i].userb.bid)){
									 $("[onclick='user_clickPostingsPraise()']").children().text(' 已点赞');
								 }
							 });
                            }
						 }
							 $.each(data.postings.details,function(item,val){
								 if(item<5){
								   $('#second').append(
									 '<div class="am-article">'
		                                + '<hr />'
		                                + '<img src="'+data.postings.details[item].userb.img+'" class="img am-radius am-fr" />'
		                                + '<p class="marginset title color"><a href="#">'+data.postings.details[item].userb.name
		                                + '</a>，'+ data.postings.details[item].userb.intro+'</p>'
		                                + '<p class="marginset title color" ><span id="dpraisenum'+data.postings.details[item].did+'">'+data.postings.details[item].praisenum+'</span> 人赞同</p>'
		                                + '<div class="content-font-size">'+data.postings.details[item].dcontent+'</div>'
		                                + '<p class="inline title">编辑于'+new Date(data.postings.details[item].replytime).toLocaleDateString()+'</p>'
		            					+ '<a href="javascript:void(0);" onclick="user_clickDetailsPraise('+data.postings.details[item].did+',this)"><span class="am-icon-thumbs-up color icon icon-margin clickpraise"> 点 赞</span></a>'
		            					+ '<a href="javascript:void(0);" onclick=user_showComments("'+data.postings.details[item].did+'","'
		             					+ data.postings.details[item].replynum+'")><span class="am-icon-comment color icon icon-margin">'+data.postings.details[item].replynum+'条评 论</span></a>'
		             					+ '<a href="javascript:void(0);" onclick="user_reportDetails('+data.postings.details[item].did+')"><span class="am-icon-bomb color icon icon-margin"> 举 报</span></a>'
									    + '</div>'	 
									  ); 
								 }else{
									 $('#second').append(
									 '<div class="am-article details-hidden">'
		                                + '<hr />'
		                                + '<img src="'+data.postings.details[item].userb.img+'" class="img am-radius am-fr" />'
		                                + '<p class="marginset title color"><a href="#">'+data.postings.details[item].userb.name
		                                + '</a>，'+ data.postings.details[item].userb.intro+'</p>'
		                                + '<p class="marginset title color" ><span id="dpraisenum'+data.postings.details[item].did+'">'+data.postings.details[item].praisenum+'</span> 人赞同</p>'
		                                + '<div class="content-font-size">'+data.postings.details[item].dcontent+'</div>'
		                                + '<p class="inline title">编辑于'+new Date(data.postings.details[item].replytime).toLocaleDateString()+'</p>'
		            					+ '<a href="javascript:void(0);" onclick="user_clickDetailsPraise("'+data.postings.details[item].did+'",this)"><span class="am-icon-thumbs-up color icon icon-margin"> 点 赞</span></a>'
		            					+ '<a href="javascript:void(0);" onclick=user_showComments("'+data.postings.details[item].did+'","'
		             					+ data.postings.details[item].replynum+'")><span class="am-icon-comment color icon icon-margin">'+data.postings.details[item].replynum+'条评 论</span></a>'
		             					+ '<a href="javascript:void(0);" onclick="user_reportDetails('+data.postings.details[item].did+')"><span class="am-icon-bomb color icon icon-margin"> 举 报</span></a>'
									    + '</div>'	  
									  ); 
								 };
								 if(data.userb!=null){
	                               if(data.postings.details[item].praise!=null){
	                            	   $.each(data.postings.details[item].praise,function(i,val){
	  									 if((data.postings.details[item].praise[i].status==1)&&(data.userb.bid==data.postings.details[item].praise[i].userb.bid)){
	  										 $('#dpraisenum'+data.postings.details[item].did).parent().next().next().next().children().text('已点赞');
	  									 }
	  								 });
	                               }
								 }
						     });
							 if(data.postings.details.length>5){
								 $('#third').append(
									'<a href="javascript:;" id="showMoreDetails" onclick="showMoreDetails()"><div class=" margin-top am-u-md-12 am-text-center am-panel am-panel-default" style="height:50px;background-color: #F0F0F0;color:black;"><div style="margin-top:10px;">加载更多..</div></div></a>'			 
								 );
							 }
							 $('#third').append(
								'<div class=" am-u-md-12 am-panel am-panel-default margin-top">'
								+'<div class=" margin-details"><img src="${sessionScope.curr_user.img}" class="img radius"/><b> ${sessionScope.curr_user.name} </b></div>'
								+'<textarea id="dcontent" class="am-u-md-12 am-radius" rows="6" ></textarea>'
								+'<button class="am-btn am-btn-primary am-radius am-btn-lg am-fr margin-details" onclick="user_insertDetails()">提交回答</button>'
								+'</div>'
							 );
							 $('#fourth').append(
								   '<div class="am-panel-group">'
								 + '<section class="am-panel am-panel-default">'
								 + '<div class="am-panel-hd">关于作者</div>'
								 + '<div class="am-panel-bd" id="user_info">'
						
							     + '</div>'
							     + '<hr style="margin-top:0px;"/>'
							     + '<button class="am-btn am-btn-primary am-radius am-left am-btn-sm" onclick="user_doSendMessage('+data.postings.userb.bid+')"><span class="am-icon-comment"></span>发私信</button> '
							     + ' <button class="am-btn am-btn-primary am-radius am-fr am-btn-sm" onclick="user_selectFriend('+data.postings.userb.bid+')"><span class="am-icon-user-plus"></span>加好友</button>'
								 + '</section>'
							     + '</div>'		 
						     );
							 $.each(data.postings.postings_theme,function(item,val){
								$('#theme').append(
								   '<a href="#" class="inline content-font-size"> '+data.postings.postings_theme[item].theme.tname+' </a>'		
								); 
							 });
							 $('#user_info').append(
								 '<img src="'+data.postings.userb.img+'" class="img-lg am-radius color"/>'
								 +'<p class="am-text-left color content-font-size">'+data.postings.userb.name+'</p>'
							     +'<p class="am-text-left color content-font-size" style="margin-bottom:0px;">'+data.postings.userb.intro+'</p>'        		 
							 );
						 }
				},
				error : function(data) {
					layer.msg('服务器出错，请稍后重试',{offset: '50%'});
				}
			});
		}
		
		
		function user_reportPostings() {
			layer.prompt({
				title : '举报',
				formType : 2,
				offset : '175px',
				area : [ '370px', '180px' ],
			}, function(data, index) {
				layer.close(index);
				var jsonStr = {
                    rcontent : data,
                    pid : ${param.pid}
				};
				$.ajax({
					type : 'GET',
					contentType : 'application/json',
					url : 'report/user_sendReport',
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
		
		function user_reportDetails(did) {
			layer.prompt({
				title : '举报',
				formType : 2,
				offset : '175px',
				area : [ '370px', '180px' ],
			}, function(data, index) {
				layer.close(index);
				var jsonStr = {
                    rcontent : data,
                    did : did
				};
				$.ajax({
					type : 'GET',
					contentType : 'application/json',
					url : 'report/user_sendReport',
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
		function user_login() {
			layer.open({
				type : 2,
				title : ' ',
				shade : false,
				offset : '4%',
				area : [ '500px', '620px' ],
				moveOut : true,
				content : 'user/user_login'
			});
		}
		function user_askQuestion() {
			layer.open({
				type : 2,
				title : '提问题',
				shadeClose : true,
				shade : 0.8,
				offset : '35px',
				area : [ '40%', '90%' ],
				content : 'postings/user_askQuestion'
			});
		}
		function user_showComments(did,replynum){
			layer.open({
				type : 2,
				title : replynum+'条评论',
				shadeClose : true,
				shade : 0.8,
				offset : '2%',
				area : [ '650px', '650px' ],
				content : 'comments/user_showComments?did='+did
			});
		}
		function user_insertDetails(){
			var pid = ${param.pid};
			var dcontent=$('#dcontent').val();
			var jsonStr={
				pid : pid,
				dcontent :dcontent
			};
			$.ajax({
				type : 'GET',
				contentType : 'application/json',
				url : 'details/user_insertDetails',
				dataType : 'json',
				data : jsonStr,
				success : function(data) {
					layer.msg(data.tips,{offset: '50%'});
					if(data.tips=='回答成功'){
						$('#second').append(
						   '<div class="am-article">'
                           + '<hr />'
                           + '<img src="'+data.details.userb.img+'" class="img am-radius am-fr" />'
                           + '<p class="marginset title color"><a href="#">'+data.details.userb.name
                           + '</a>，'+ data.details.userb.intro+'</p>'
                           + '<p class="marginset title color">'+data.details.replynum+' 人赞同</p>'
                           + '<div class="content-font-size">'+data.details.dcontent+'</div>'
                           + '<p class="inline title">编辑于'+new Date(data.details.replytime).toLocaleDateString()+'</p>'
      					   + '<a href="#"><span class="am-icon-thumbs-up color icon icon-margin"> 点 赞</span></a>'
      					   + '<a href="javascript:void(0);" onclick=user_showComments("'+data.details.did+'","'
           				   + data.details.replynum+'")><span class="am-icon-comment color icon icon-margin">'+data.details.replynum+'条评 论</span></a>'
           				   +'<a href="javascript:void(0);" onclick="user_reportDetails('+data.details.did+')"><span class="am-icon-bomb color icon icon-margin"> 举 报</span></a>'
					       + '</div>'	  
						);
						$('#dcontent').val('');
						$('#replynum').text($('#replynum').text()-(-1));
					}
				},
				error : function(data) {
					layer.msg('服务器出错，请稍后重试',{offset: '50%'});
				}
			});
		}
		
		function moveToDcontent(){
			$('#dcontent').focus();
		}
		function showMoreDetails(){
			if($('.details-hidden').length>8){
				for(var i=0;i<5;i++){
					$('.details-hidden:eq('+i+')').removeClass("details-hidden");
				}
			}else{
				$('.details-hidden').removeClass("details-hidden");
			}
			if($('.details-hidden').length<=0){
			  $('#showMoreDetails').addClass("details-hidden");	
			}
		}
		
		function user_doSendMessage(id) {
			layer.prompt({
				title : '发私信',
				formType : 2,
				offset : '145px',
				area : [ '480px', '260px' ],
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
		
		function user_clickPostingsPraise(){
			var praisenum=$('#praisenum');
			var pid = ${param.pid};
			var jsonStr = {
				'postings.pid' : pid,
				'details.did' : 0,
				'comments.cid' : 0
// 					pid:pid
			};
			$.ajax({
				type : 'GET',
				contentType : 'application/json',
				url : 'praise/user_clickPraise',
				data : jsonStr,
				dataType : 'json',
				success : function(data) {
					if(data.tips=='点赞成功'){
					   praisenum.text(praisenum.text()-(-1));
					   $("[onclick='user_clickPostingsPraise()']").children().text(' 已点赞');
					}else if(data.tips=='撤赞成功'){
					   praisenum.text(praisenum.text()-1);	
					   $("[onclick='user_clickPostingsPraise()']").children().text(' 点赞');
					}else{
					   layer.msg(data.tips,{offset: '50%'});
					}
				},
				error : function(data) {
					layer.msg('服务器出错，请稍后重试',{offset: '50%'});
				}
			});
		}
		
		function user_clickDetailsPraise(did,obj){
			var dpraisenum = $('#dpraisenum'+did);
			var dclickparise = $(obj);
			var jsonStr = {
				'details.did' : did,
				'postings.pid' : 0,
				'comments.cid' : 0
//                 did:did
			};
			$.ajax({
				type : 'GET',
				contentType : 'application/json',
				url : 'praise/user_clickPraise',
				data : jsonStr,
				dataType : 'json',
				success : function(data) {
					if(data.tips=='点赞成功'){
						dpraisenum.text(dpraisenum.text()-(-1));
// 						dpraisenum.parent().next().next().next().children().text('已点赞');
						dclickparise.children().text('已点赞');
					}else if(data.tips=='撤赞成功'){
						dpraisenum.text(dpraisenum.text()-1);
						dclickparise.children().text('点赞');
					}else{
						layer.msg(data.tips,{offset: '50%'});
					}
				},
				error : function(data) {
					layer.msg('服务器出错，请稍后重试',{offset: '50%'});
				}
			});
		}
		
		function user_showMessage() {
			layer.open({
				type : 2,
				title : '信息',
				shadeClose : true,
				shade : 0.8,
				offset : '3%',
				area : [ '450px', '600px' ],
				moveOut : true,
				content : 'msg/user_showMessage'
			});
		}
		
		function getMsgCount(){
		   $.ajax({
			   type:'GET',
			   contentType:'application/json',
			   url:'msg/user_getMsgCount',
			   dataType:'json',
			   success:function(data){
				  if(data.count>0){
					  $('#msgCount').text(' '+data.count); 
				  }else{
					  $('#msgCount').text('');
				  } 
			   },
			   error:function(data){
				   layer.msg('服务器出错，请稍后重试',{offset: '50%'});
			   }	   
		   });
		}
		
		function user_addFriend(id){
           var jsonStr = {
        	   'userf.bid' : id	   
           };		   	
           $.ajax({
        	   type:'GET',
        	   contentType:'application/json',
        	   url:'friend/user_insertFriend',
        	   data:jsonStr,
        	   dataType:'json',
        	   success:function(data){
        		   layer.msg(data.tips,{offset: '50%'});
        	   },
        	   error:function(data){
        		   layer.msg('服务器出错，请稍后重试',{offset: '50%'});
        	   }
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
						layer.msg(data.tips);
					}
				},
				error : function(data){
					layer.msg('服务器出错，请稍后重试');
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
		
		function user_selectTitleList() {
			var title = $('#title').val();
			var list = $('#titleList');
			var suggest = "";
			var jsonStr = {
				title : title
			};
			if (title != "") {
				$.ajax({
					type : 'GET',
					contentType : 'application/json',
					url : 'postings/user_selectTitleList',
					data : jsonStr,
					dataType : 'json',
					success : function(data) {
						if (data.list != null) {
							$(data.list).each(
							function(i, obj) {
								suggest += '<li><a href="javascript:void(0);" id="title" onclick="selectTitle('
										+ obj.pid
										+',this)">'
										+ obj.title
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
			var titleList = $('#titleList');
			setTimeout(function() {
				titleList.html('');
			}, 150);
		}

		function selectTitle(pid,obj) {
			var title=$('#title').val(obj.innerHTML);
			$('#titleList').html('');
			if(title!=''){
			  $('#searchpid').val(pid);
			}else{
			  $('#searchpid').val('');	
			}
			$('#title').focus();
		}
		
		function user_searchPostings(){
			var pid = $('#searchpid').val();
			var title = $('#title').val();
			if((pid!='')&&(title!='')) location.href='user_postings.jsp?pid='+pid;
		}
	</script>
</body>
</html>
