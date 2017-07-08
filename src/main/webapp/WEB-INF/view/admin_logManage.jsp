<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>admin_logManager</title>
    
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
    function admin_deleteLog() {
        var selectedRows = $("#dg").datagrid("getSelections");
        if (selectedRows.length == 0) {
            $.messager.alert("系统提示", "请选择要删除的日志信息！");
            return;
        }
        var strIds = [];
        for ( var i = 0; i < selectedRows.length; i++) {
            strIds.push(selectedRows[i].lid);
        }
        var ids = strIds.join(",");
        $.messager.confirm("系统提示", "您确定要删除这<font color=red>"
                + selectedRows.length + "</font>条日志信息吗？", function(r) {
            if (r) {
            	var jsonStr = {
            		lids : ids	
            	};
            	$.ajax({
            		type : 'GET',
            		contentType : 'application/json',
            		url : 'log/admin_deleteLog',
            		data : jsonStr,
            		dataType : 'json',
            		success : function(data){
            			if(data.tips=='删除成功'){
            			    $.messager.alert("系统提示", "日志记录已成功删除！");
                            $("#dg").datagrid("reload");
            			}else{
            				$.messager.alert("系统提示", "日志记录删除失败，请联系系统管理员！");
            			}
            		},
            		error : function(data){
            		}
            	});
            }
        });
       }
    
       function admin_searchLog(){
           var aid = $('#aid').val();
           var bid = $('#bid').val();
           var content = $('#content').val();
           var operation = $('#operation').val();
           var requestip = $('#requestip').val();
           var logStart = $('#logStart').val();
           var logEnd = $('#logEnd').val();
   		   $('#dg').datagrid('load', {    
   			aid: aid,
   			bid : bid,
   			content : content,
   			operation : operation,
   			requestip : requestip,
   			logStart : logStart,
   			logEnd : logEnd
  	       });  
    	   
    	   $('#dg').datagrid('reload');
       }
       
       function clearCondition(){
    	   $('.condition').val('');
       }
  </script> 
  </head>
  
  <body>
    <!-- 日志列表框 -->
	<table id="dg" title="日志管理" class="easyui-datagrid" 
			url="log/admin_selectLogList" method="GET" pagination="true" 
			toolbar="#toolbar" striped="true"
			rownumbers="true" fitColumns="true" singleSelect="1" fit="true">
		<thead>
			<tr>
			    <th field="cb" checkbox="true" align="center"></th>
				<th field="lid" width="15" align="center">编号</th>
				<th field="admin" width="15" align="center" data-options="formatter:function(value){return value.aid;}">管理员编号</th>
				<th field="userb" width="15" align="center" data-options="formatter:function(value){return value.bid;}">用户编号</th>
				<th field="content" width="50" align="center">操作内容</th>
				<th field="operation" width="100" align="center">操作方法</th>
			    <th field="requestip" width="30" align="center">请求ip</th>
			    <th field="createdate" width="30" align="center">日志时间</th>
			</tr>
		</thead>
	</table>

	<div id="toolbar">
		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="admin_deleteLog()">删除日志</a>
        		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-clear" plain="true" onclick="clearCondition()">清除所有条件</a>
        <br>
        &nbsp;管理员编码：&nbsp;<input type="text" id="aid" size="20" class="condition"
        onkeydown="if(event.keyCode == 13)admin_searchLog()" style="width:50px;"/> 
        
        &nbsp;用户编号：&nbsp;<input type="text" id="bid" size="20" class="condition"
        onkeydown="if(event.keyCode == 13)admin_searchLog()" style="width:50px;"/>
        
        &nbsp;操作内容：&nbsp;<input type="text" id="content" size="20" class="condition"
        onkeydown="if(event.keyCode == 13)admin_searchLog()" style="width:150px;"/>
        
        &nbsp;操作方法：&nbsp;<input type="text" id="operation" size="20" class="condition"
        onkeydown="if(event.keyCode == 13)admin_searchLog()" style="width:150px;"/>
        
        &nbsp;请求ip地址：&nbsp;<input type="text" id="requestip" size="20" class="condition"
        onkeydown="if(event.keyCode == 13)admin_searchLog()" style="width:100px;"/>
        
        &nbsp;日志起始时间：&nbsp;
        <input id="logStart" type="text" size="20" class="easyui-datebox condition" onkeydown="if(event.keyCode == 13)admin_searchLog()" style="width:100px;"/> 
        -
        &nbsp;日志结束时间：&nbsp;
        <input id="logEnd" type="text" size="20" class="easyui-datebox condition" onkeydown="if(event.keyCode == 13)admin_searchLog()" style="width:100px;"/>  

         <a href="javascript:admin_searchLog()" class="easyui-linkbutton"
        iconCls="icon-search" plain="true">查询</a>
	</div>
	<div id="pp" class="easyui-pagination" data-options="total:2000,pageSize:10" style="background:#efefef;border:1px solid #ccc;"></div> 

 
  </body>
</html>
