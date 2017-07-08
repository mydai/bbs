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

<title>顶部导航栏</title>

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
<link rel="stylesheet" href="resources/amazeui/css/admin.css">
	<!--[if lt IE 9]>
<script src="http://libs.baidu.com/jquery/1.11.1/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->


</head>

<body>
	<header class="am-topbar am-topbar-inverse admin-header">
	<div class="am-topbar-brand">
		<strong>个人中心</strong>
		<a href="javascript:void(0);" onclick="user_index()" style="font-size:15px;">回到首页</a>
	</div>

	<button
		class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only"
		data-am-collapse="{target: '#topbar-collapse'}">
		<span class="am-sr-only"></span> <span class="am-icon-bars"></span>
	</button>

	<div class="am-collapse am-topbar-collapse" id="topbar-collapse">

<!-- 	<ul class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list">
			<li><a href="javascript:;"><span class="am-icon-envelope-o"></span>
					消息 <span class="am-badge am-badge-warning">5</span></a></li>
			<li class="am-dropdown" data-am-dropdown><a
				class="am-dropdown-toggle" data-am-dropdown-toggle href=""> <span
					class="am-icon-users"></span> ${sessionScope.curr_user.name } <span
					class=""></span>
			</a></li>
		</ul> -->	
	</div>
	</header>
	<!--[if (gte IE 9)|!(IE)]><!-->
	<script src="resources/amazeui/js/jquery-2.1.4.js"></script>
	<!--<![endif]-->
	<script src="resources/amazeui/js/amazeui.js"></script>
	<script type="text/javascript">
	  $(function(){
		  user_getTopInfo();
	  });
	  function user_getTopInfo(){
          $.ajax({
       	   type:'GET',
       	   contentType:'application/json',
       	   url:'msg/user_getMsgCount',
       	   dataType:'json',
       	   success:function(data){
       		   if(data.userb!=null){
    			  $('#topbar-collapse').append(
   					'<ul class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list">'
   					+'<li><a href="javascript:;" onclick="parent.window.frames["rightFrame"].user_showMessage();" ><span class="am-icon-envelope-o">'
   					+'</span> 消息  <span class="am-badge am-badge-warning am-radius">'
   					+ data.count
   					+'</span></a></li>'
   					+'<li class="am-dropdown" data-am-dropdown>'
   					+'<a class="am-dropdown-toggle" data-am-dropdown-toggle href="">' 
   					+'<span class="am-icon-users"></span>'
   					+ data.userb.name
   					+'<span class=""></span>'
   					+'</a></li>'
   					+'</ul>'
   				  );   
       		   }
       	   },
       	   error:function(data){
       		   layer.msg('服务器出错，请稍后重试',{offset: '50%'});
       	   }
          });
	  }

	  function user_index(){
		  parent.window.location.href = 'index.jsp';
	  }
	  
	</script>
</body>
</html>
