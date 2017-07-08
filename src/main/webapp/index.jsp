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
	width: 120px;
}

.left {
/* 	border: 1px solid red; */
	width: 50px;
}

.right {
/*     margin-right:5%; */
/* 	border: 1px solid red; */
}

.title {
	color: gray;
	font-size: 13px;
	padding: 0px;
/* 		border: 1px solid red; */
}

#titleList{
  margin-top:0px;
  position: absolute;
  width:300px;
}

.content {
	color: black;
	padding: 0px;
	font-size: 13px;
}

.color {
/* 			border: 1px solid red; */
	
}

.marginset {
	margin: 0px;
}

.img {
	width: 35px;
	height: 35px;
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
	margin-top: 70px;
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

.line-clamp {
	overflow: hidden;
	text-overflow: ellipsis;
	display: -webkit-box;
	-webkit-line-clamp: 3;
	-webkit-box-orient: vertical;
	font-size: 15px;
	color: black;
}

.margin-bottom {
	margin-bottom: 3px;
}

.inline {
	display: inline;
}

.content-font-size {
	font-size: 14px;
}

.theme {
	
}
.praisenum{
    background-color: #F0FFF0;
    width: 35px;
    height:25px;
    color:#7EC0EE;
}
.clickpraise{
    color:gray;
}
</style>
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
		$(function() {
			user_selectPostingsList();
		});

		function user_selectPostingsList() {
			var first = $('#first');
			var jsonStr = {};
			$.ajax({
				type : 'GET',
				contentType : 'application/json',
				url : 'postings/user_selectPostingsList',
				data : jsonStr,
				dataType : 'json',
				success : function(data) {
					if(data.userb!=null){
				 	   setInterval ("getMsgCount()", 5000);
					}
					if (data.tips != '') {
					  if(data.tips =='获取成功'){
						  $.each(data.postingsList,
							function(item, val) {
								
								first.append('<article class="blog-main color am-u-md-12 acticle">'
									+ '<hr class="avg color" />'
									+ '<div class="am-fl left">'
									+ '<a href="#"><img src="'+data.postingsList[item].userb.img+'" class="img am-radius"></a>'
									+ '<div class="praisenum am-radius am-text-center" style="margin-top:4px;" id="praisenum'+data.postingsList[item].pid+'">'+data.postingsList[item].praisenum+'</div>'
									+ '</div>'
									+ '<div class=" am-u-sm-9 am-u-md-10 am-u-lg-10 am-fl right">'
									+ '<span class="color title">热门题目,來自:</span>'
									+ '<div class="inline theme">'
									+ '</div>'
									+ '<h3 class="blog-title color marginset"><a href="user_postings.jsp?pid='
									+ data.postingsList[item].pid
									+ '">'
									+ data.postingsList[item].title
									+ '</a></h3>'
									+ '<div class="color marginset ">'
									+ '<a href="#" class="content"><b>'
									+ data.postingsList[item].userb.name
									+ ',</b></a><span class="title">'
									+ data.postingsList[item].userb.intro
									+ '</span>'
									+ '</div>'
									+ '<div class="am-g color ">'
									+ '<div class="am-u-md-11">'
									+ '<a href="user_postings.jsp?pid='
									+ data.postingsList[item].pid
									+ '">'
									+ '<p class="line-clamp margin-bottom ">'
									+ data.postingsList[item].pcontent
									+ '</p>'
									+ '</a>'
									+ '</div>'
									+ '</div>'
									+ '<a href="#"><span class="am-icon-plus color icon"> 关 注</span></a>'
									+ '<a href="javascript:void(0);" onclick="user_clickPraise('+data.postingsList[item].pid+',this)"><span class="am-icon-thumbs-up color icon icon-margin">点 赞</span></a>'
									+ '<a ><span class="am-icon-comment color icon icon-margin">'
									+ data.postingsList[item].replynum
									+ ' 个回答</span></a>'
									+ '<a href="#"><span class="am-icon-share color icon icon-margin">分 享</span></a>'
		
									+ '<a href="#"><span class="am-icon-bookmark color icon icon-margin"> 收 藏</span></a>'
									+ '<a href="javascript:void(0);" onclick="user_report('
									+ data.postingsList[item].pid
									+ ')"><span class="am-icon-bomb color icon icon-margin"> 举 报</span></a>'
									+ '</div>'
									+ '</article>');
								
                                //循环出帖子的主题信息
// 								$.each(data.postingsList[item].postings_theme,
// 									function(it,val) {
// 										$('.theme').eq(item).append(
// 										'<a href="#" class="inline content-font-size"> '
// 										+ data.postingsList[item].postings_theme[0].theme.tname
// 										+ ' </a>');  
// 									});
								if(data.userb!=null){
	                               if(data.postingsList[item].praise!=null){
	                            	 $.each(data.postingsList[item].praise,function(i,val){
	  									 if((data.postingsList[item].praise[i].status==1)&&(data.userb.bid==data.postingsList[item].praise[i].userb.bid)){
	  									   $('#praisenum'+data.postingsList[item].pid).parent().next().children("a:eq(1)").children().text('已点赞');
	  									 }
	  								});
	                              }
								}
							});
					  }else{
						  layer.msg(data.tips);
					  }
					}
				},
				error : function(data) {
					layer.msg('服务器出错，请稍后重试');
				}
			});
		}

		function user_showMessage() {
			layer.open({
				type : 2,
				title : '发送私信',
				shadeClose : true,
				shade : 0.8,
				offset : '3%',
				area : [ '450px', '600px' ],
				moveOut : true,
				content : 'msg/user_showMessage'
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
		function user_report(pid) {
			layer.prompt({
				title : '举报',
				formType : 2,
				offset : '175px',
				area : [ '370px', '180px' ],
			}, function(data, index) {
				layer.close(index);
				var jsonStr = {
					pid : pid,
					rcontent : data
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
		function user_login() {
			layer.open({
				type : 2,
				title : ' ',
				shade : false,
				offset : '4%',
				area : [ '450px', '620px' ],
				moveOut : true,
				content : 'user/user_login'
			});
		}
		function share(){
		   layer.msg('出现了啊，二维码');
		   var condition = {
			  text: 'localhost:8080/ssm/user_postings.jsp?pid=1', // 要生产二维码的文字
			  width: 115, // 二维码宽度 `px`
			  height: 115, // 二维码高度 `px`
			  correctLevel: 3, // 纠错级别，可取 0、1、2、3，数字越大说明所需纠错级别越大
			  background: "#ffffff", // 背景色
			  foreground: "#000000" // 前景色
			};
            $qr = $('.doc-qrcode');
			function makeCode() {
				$qr.empty().qrcode(condition);
			}
			makeCode();
		}
		
		function user_clickPraise(pid,obj){
			var praisenum = $('#praisenum'+pid);
			var clickpraise = $(obj);
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
// 						praisenum.parent().next().children("a:eq(1)").children().text('已点赞');
						clickpraise.children().text('已点赞');
						
					}else if(data.tips=='撤赞成功'){
						praisenum.text(praisenum.text()-1);
						clickpraise.children().text('点赞');
					}else{
						layer.msg(data.tips);
					}
				},
				error : function(data) {
					layer.msg('服务器出错，请稍后重试');
				}
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
				   layer.msg('服务器出错，请稍后重试');
			   }	   
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
			<li class="am-active"><a href="#">首页</a></li>
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
					<a href="#top" title="回到顶部" class="am-radius"> <span
						class="am-icon-arrow-up "></span>
					</a>
				</div>
			</div>
		</div>
		<div class="am-u-md-8" id="first">
		   
		</div>

		<div class="am-u-md-3 am-u-end blog-sidebar">
			<div class="am-panel-group">
				<section class="am-panel am-panel-default">
				<div class="am-panel-hd">关于项目</div>
				<div class="am-panel-bd">
					<p>本人崔志翔，是黄山学院13计本的一名大四学生，由于要完成毕设设计便开始了这个项目，
					在做项目的同时也不断的学习新的知识，该项目自2016年12月份开始写，由于工作原因没什么时间写直到2017年4月才得以完成，历时5个月，
					该项目是javaweb项目，整体的功能和界面构思是来源于知乎和百度贴吧，框架是用ssm+maven,前台的前端框架使用amazeui+layerui，后台的前端框架使用easyui+bootstrap3，
					后台的功能很简单基本上就是增删改查，花了3天时间完成，在项目完成期间遇到了很多的问题，很多都是第一次遇到，大部分都是百度解决了，还有一些功能实在不好完成就换了种实现方式或者是阉割了,
					还有部分功能没有完成。
					</p>
				</div>
				</section>
			</div>
		</div>
	</div>
	<footer class="blog-footer">
	<p>
		<br/> <small>© Copyright daidaizhizuo </small>
	</p>
	</footer>

</body>
</html>
