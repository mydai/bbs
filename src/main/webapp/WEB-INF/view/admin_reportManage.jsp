<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>admin_reportManager</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    <link rel="stylesheet" type="text/css" href="resources/easyui/themes/default/easyui.css">   
    <link rel="stylesheet" type="text/css" href="resources/easyui/themes/icon.css"> 
     <script type="text/javascript" src="resources/easyui/jquery.min.js"></script>   
  <script type="text/javascript" src="resources/easyui/jquery.easyui.min.js"></script> 
    <script type="text/javascript" src="resources/easyui/locale/easyui-lang-zh_CN.js"></script> 
  <script type="text/javascript">
    function admin_deleteReport() {
        var selectedRows = $("#dg").datagrid("getSelections");
        if (selectedRows.length == 0) {
            $.messager.alert("系统提示", "请选择要删除的投诉信息！");
            return;
        }
        var strIds = [];
        for ( var i = 0; i < selectedRows.length; i++) {
            strIds.push(selectedRows[i].rid);
        }
        var ids = strIds.join(",");
        $.messager.confirm("系统提示", "您确定要删除这<font color=red>"
                + selectedRows.length + "</font>条投诉信息吗？", function(r) {
            if (r) {
            	var jsonStr = {
            		rids : ids	
            	};
            	$.ajax({
            		type : 'GET',
            		contentType : 'application/json',
            		url : 'report/admin_deleteReport',
            		data : jsonStr,
            		dataType : 'json',
            		success : function(data){
            			if(data.tips=='删除成功'){
            			    $.messager.alert("系统提示", "投诉记录已成功删除！");
                            $("#dg").datagrid("reload");
            			}else{
            				$.messager.alert("系统提示", "投诉记录删除失败，请联系系统管理员！");
            			}
            		},
            		error : function(data){
            		}
            	});
            }
        });
       }
    
       function admin_searchReport(){
    	   var rcontent = $('#rcontent').val();
    	   var bid = $('#bid').val();
    	   var pid = $('#pid').val();
    	   var did = $('#did').val();
    	   var cid = $('#cid').val();
    	   var reportStart = $('#reportStart').val();
    	   var reportEnd = $('#reportEnd').val(); 
   		   $('#dg').datagrid('load', {    
   			rcontent: rcontent,
   			bid : bid,
   			pid : pid,
   			did : did,
   			cid : cid,
   			reportStart : reportStart,
   			reportEnd : reportEnd
  	       });  
    	   
    	   $('#dg').datagrid('reload');
       }
       
       function clearCondition(){
    	   $('.condition').val('');
       }
  </script> 
  </head>
  
  <body>
    <!-- 投诉列表框 -->
	<table id="dg" title="投诉管理" class="easyui-datagrid" 
			url="report/admin_selectReportList" method="GET" pagination="true" 
			toolbar="#toolbar" striped="true"
			rownumbers="true" fitColumns="true" singleSelect="1" fit="true">
		<thead>
			<tr>
			    <th field="cb" checkbox="true" align="center"></th>
				<th field="rid" width="15" align="center">编号</th>
				<th field="bid" width="15" align="center">投诉人编号</th>
				<th field="rcontent" width="100" align="center">投诉内容</th>
				<th field="reporttime" width="30" align="center">投诉时间</th>
				<th field="pid" width="15" align="center">帖子编号</th>
				<th field="did" width="15" align="center">回答编号</th>
				<th field="cid" width="15" align="center">评论编号</th>
			</tr>
		</thead>
	</table>

	<div id="toolbar">
		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="admin_deleteReport()">删除投诉</a>
        		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-clear" plain="true" onclick="clearCondition()">清除所有条件</a>
        <br>
        &nbsp;投诉内容：&nbsp;<input type="text" id="rcontent" size="20" class="condition"
        onkeydown="if(event.keyCode == 13)admin_searchReport()" style="width:200px;"/> 
        
        &nbsp;投诉人编号：&nbsp;<input type="text" id="bid" size="20" class="condition"
        onkeydown="if(event.keyCode == 13)admin_searchReport()" style="width:50px;"/>
        
        &nbsp;帖子编号：&nbsp;<input type="text" id="pid" size="20" class="condition"
        onkeydown="if(event.keyCode == 13)admin_searchReport()" style="width:50px;"/>
        
        &nbsp;回答编号：&nbsp;<input type="text" id="did" size="20" class="condition"
        onkeydown="if(event.keyCode == 13)admin_searchReport()" style="width:50px;"/>
        
        &nbsp;评论编号：&nbsp;<input type="text" id="cid" size="20" class="condition"
        onkeydown="if(event.keyCode == 13)admin_searchReport()" style="width:50px;"/>
        
        &nbsp;投诉起始时间：&nbsp;
        <input id="reportStart" type="text" size="20" class="easyui-datebox condition" onkeydown="if(event.keyCode == 13)admin_searchReport()" style="width:100px;"/> 
        -
        &nbsp;投诉结束时间：&nbsp;
        <input id="reportEnd" type="text" size="20" class="easyui-datebox condition" onkeydown="if(event.keyCode == 13)admin_searchReport()" style="width:100px;"/>  

         <a href="javascript:admin_searchReport()" class="easyui-linkbutton"
        iconCls="icon-search" plain="true">查询</a>
	</div>
	<div id="pp" class="easyui-pagination" data-options="total:2000,pageSize:10" style="background:#efefef;border:1px solid #ccc;"></div> 

 
  </body>
</html>
