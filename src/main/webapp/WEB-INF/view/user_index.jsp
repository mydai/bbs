<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>admin_right</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css"
	href="resources/bootstrap-3.3.7/css/bootstrap.css" />
	<link href="resources/amazeui/css/amazeui.css" type="text/css"
	rel="stylesheet">
<style type="text/css">
 .trends{
 margin:0px;
 paddding:0px;
 }
 .img{
 width:30px;
 height:30px;
}
</style>

  </head>
  
  <body>
    <div class="am-g">
        <div>
        <span class="am-badge am-badge-success am-radius" style="float:left;">我的动态</span>
		<div class="am-u-md-6 am-u-sm-4" id="left">
		</div>
		</div>
		<div id="right" class="am-fr" style="width: 450px;height:250px;"></div>
    </div>
   	<script src="resources/amazeui/js/jquery-2.1.4.js"></script>
	<script type="text/javascript" src="resources/amazeui/js/amazeui.js"></script>
	<script type="text/javascript" src="resources/layui/lay/dest/layui.all.js"></script>
    <script type="text/javascript" src="resources/echarts/echarts.min.js"></script>
    <script type="text/javascript" src="resources/layui/lay/dest/layui.all.js"></script>
    <script type="text/javascript">
	$(function() {
		user_selectPostings();
	    showEcharts();
	});
	
	function user_selectPostings(){
		 $.ajax({
			   type : 'GET',
			   contentType : 'application',
			   url : 'postings/user_selectUserbPostings',
			   data : '',
			   dataType : 'json',
			   success : function(data){
				  $.each(data.list,function(item,val){	
					  $('#left').append(
						'<div class="am-u-sm-12">'
						+'<p class="trends">'+new Date(val.publishtime).toLocaleDateString()+'</p>'
						+'<hr class="trends"/>'
						+'<p ><a href="javascript:void(0);" onclick="skip('+val.pid+')"> '+val.title +'</a> '+val.praisenum +'赞  '+val.replynum +'评论</p>'
						+'</div>'			  
					  );  
				  });
			   },
			   error : function(data){
	             layer.msg('服务器出错，请稍后重试！');		   
			   }
		   });
	}
	
	function showEcharts(){
	   $.ajax({
		   type : 'GET',
		   contentType : 'application',
		   url : 'user/user_selectAllCount',
		   data : '',
		   dataType : 'json',
		   success : function(data){
			    
				var firstChart = echarts.init(document.getElementById('right'));
				var firstOption = {
					    title : {
					        text: '我的信息',
					        x:'center'
					    },
					    tooltip : {
					        trigger: 'item',
					        formatter: "{a} <br/>{b} : {c} ({d}%)"
					    },
					    legend: {
					        orient: 'vertical',
					        left: 'left',
					        data: ["我的帖子","我的回答","我的评论","我的短信息","获赞数","我的投诉"]
					    },
					    series : [
					        {
					            name: '统计',
					            type: 'pie',
					            radius : '55%',
					            center: ['50%', '60%'],
					            data:[
					                {value:data.count[0], name:'我的帖子'},
					                {value:data.count[1], name:'我的回答'},
					                {value:data.count[2], name:'我的评论'},
					                {value:data.count[3], name:'我的短信息'},
					                {value:data.count[4], name:'获赞数'},
					                {value:data.count[5], name:'我的投诉'}
					            ],
					            itemStyle: {
					                emphasis: {
					                    shadowBlur: 10,
					                    shadowOffsetX: 0,
					                    shadowColor: 'rgba(0, 0, 0, 0.5)'
					                }
					            }
					        }
					    ]
					};
				 firstChart.setOption(firstOption);
		   },
		   error : function(data){
             layer.msg('服务器出错，请稍后重试！');		   
		   }
	   });
	}
	
	function skip(pid){
		window.parent.location.href = 'user_postings.jsp?pid='+pid;
	}
	
    </script>
  </body>
</html>
