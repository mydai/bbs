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
		<script src="resources/amazeui/js/jquery-2.1.4.js"></script>
    <script type="text/javascript" src="resources/echarts/echarts.min.js"></script>
    <script type="text/javascript" src="resources/layui/lay/dest/layui.all.js"></script>
    <script type="text/javascript">
	$(function() {
		showEcharts();
	});
	function showEcharts(){
	   $.ajax({
		   type : 'GET',
		   contentType : 'application',
		   url : 'admin/admin_selectAllCount',
		   data : '',
		   dataType : 'json',
		   success : function(data){
			   var myChart = echarts.init(document.getElementById('main'));

			    // 指定图表的配置项和数据
			    var option = {
			        title: {
			            text: '统计'
			        },
			        tooltip: {},
			        legend: {
			            data:['']
			        },
			        xAxis: {
			            data: ["用户人数","帖子数","回答数","评论数","短信息数","获赞数","投诉数"]
			        },
			        yAxis: {},
			        series: [{
			            name: '数量',
			            type: 'bar',
			            data: [data.count[0],data.count[1],data.count[2],data.count[3],data.count[4],data.count[5],data.count[6]]
			        }]
			    };

			    // 使用刚指定的配置项和数据显示图表。
			    myChart.setOption(option);
			    
				var firstChart = echarts.init(document.getElementById('first'));
				var firstOption = {
					    title : {
					        text: '所有的统计',
					        x:'center'
					    },
					    tooltip : {
					        trigger: 'item',
					        formatter: "{a} <br/>{b} : {c} ({d}%)"
					    },
					    legend: {
					        orient: 'vertical',
					        left: 'left',
					        data: ["用户人数","帖子数","回答数","评论数","短信息数","获赞数","投诉数"]
					    },
					    series : [
					        {
					            name: '统计',
					            type: 'pie',
					            radius : '55%',
					            center: ['50%', '60%'],
					            data:[
					                {value:data.count[0], name:'用户人数'},
					                {value:data.count[1], name:'帖子数'},
					                {value:data.count[2], name:'回答数'},
					                {value:data.count[3], name:'评论数'},
					                {value:data.count[4], name:'短信息数'},
					                {value:data.count[5], name:'获赞数'},
					                {value:data.count[6], name:'投诉数'}
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

    </script>
  </head>
  
  <body>
    <div id="main" style="width: 500px;height:300px;float:left;"></div>
    <div id="first" style="width: 500px;height:300px;float:left;margin-left:100px;"></div>

  </body>
</html>
