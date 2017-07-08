<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>admin_msgManager</title>
    
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
    
    function closeMsgDialog() {
        $("#dlg").dialog("close");
        resetValue();
    }

    function admin_insertMsg(){
    	$('#dlg').dialog('open').dialog('setTitle','添加新信息');
    	$('#fm').form('clear');
    	url = 'msg/admin_insertMsg';
    }
    
    function admin_saveMsg(){
    	$('#fm').form('submit',{
    		url: url,
    		onSubmit: function(){
    			return $(this).form('validate');
    		},
    		success: function(data){
    			var result = eval('('+data+')');
    			if(result.tips=='成功'){
    				$('#dg').datagrid('reload');
    			}
    			$.messager.alert({
    				title : '提示',
    				msg : result.tips
    			});
    		}
    	});
    }
    
    function admin_deleteMsg() {
        var selectedRows = $("#dg").datagrid("getSelections");
        if (selectedRows.length == 0) {
            $.messager.alert("系统提示", "请选择要删除的短信息！");
            return;
        }
        var strIds = [];
        for ( var i = 0; i < selectedRows.length; i++) {
            strIds.push(selectedRows[i].mid);
        }
        var ids = strIds.join(",");
        $.messager.confirm("系统提示", "您确定要删除这<font color=red>"
                + selectedRows.length + "</font>条短信息吗？", function(r) {
            if (r) {
            	var jsonStr = {
            		mids : ids	
            	};
            	$.ajax({
            		type : 'GET',
            		contentType : 'application/json',
            		url : 'msg/admin_deleteMsg',
            		data : jsonStr,
            		dataType : 'json',
            		success : function(data){
            			if(data.tips=='删除成功'){
            			    $.messager.alert("系统提示", "短信息已成功删除！");
                            $("#dg").datagrid("reload");
            			}else{
            				$.messager.alert("系统提示", "短信息删除失败，请联系系统管理员！");
            			}
            		},
            		error : function(data){
            		}
            	});
            }
        });
       }
    
       function admin_searchMsg(){
    	   var bid = $('#bid').val();
    	   var sendto = $('#sendto').val();
    	   var mcontent = $('#mcontent').val();
//     	   var status = $('#status').val();
//     	   var mark = $('#mark').val();
    	   var msgStart = $('#msgStart').val();
    	   var msgEnd = $('#msgEnd').val(); 
       		   $('#dg').datagrid('load', { 
       			bid : bid,
       			sendto : sendto,
       			mcontent: mcontent,
       			msgStart : msgStart,
       			msgEnd : msgEnd
       	       });
    	   $('#dg').datagrid('reload');
       }
       
       function clearCondition(){
    	   $('.condition').val('');
       }
  </script> 
  </head>
  
  <body>
    <!-- 信息列表框 -->
	<table id="dg" title="短信息管理" class="easyui-datagrid" 
			url="msg/admin_selectMsgtList" method="GET" pagination="true" 
			toolbar="#toolbar" striped="true"
			rownumbers="true" fitColumns="true" singleSelect="1" fit="true" >
		<thead>
			<tr>
			    <th field="cb" checkbox="true" align="center"></th>
				<th field="mid" width="15" align="center">编号</th>
	            <th field="userb" width="15" align="center" data-options="formatter:function(value){return value.bid;}">发送人编号</th>
				<th field="sendto" width="15" align="center">接收人编号</th>
				<th field="mcontent" width="100" align="center">短信息内容</th>
				<th field="senddate" width="30" align="center">发送时间</th>
				<th field="status" width="15" align="center">状态码</th>
				<th field="mark" width="15" align="center">已读标志码</th>
			</tr>
		</thead>
	</table>

	<div id="toolbar">
		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="admin_insertMsg()">添加短信息</a>
		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="admin_deleteMsg()">删除短信息</a>
        		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-clear" plain="true" onclick="clearCondition()">清除所有条件</a>
        <br>
        &nbsp;发送人编号：&nbsp;<input type="text" id="bid" size="20" class="condition"
        onkeydown="if(event.keyCode == 13)admin_searchMsg()" style="width:50px;"/>
        
        &nbsp;接收人编号：&nbsp;<input type="text" id="sendto" size="20" class="condition"
        onkeydown="if(event.keyCode == 13)admin_searchMsg()" style="width:50px;"/>
        
        &nbsp;短信息内容：&nbsp;<input type="text" id="mcontent" size="20" class="condition"
        onkeydown="if(event.keyCode == 13)admin_searchMsg()" style="width:50px;"/> 
        
<!--          &nbsp;状态码：&nbsp;<input type="text" id="status" size="20"
        onkeydown="if(event.keyCode == 13)admin_searchMsg()" style="width:50px;"/> 
        
         &nbsp;已读标志码：&nbsp;<input type="text" id="mark" size="20"
        onkeydown="if(event.keyCode == 13)admin_searchMsg()" style="width:50px;"/>  -->
        
        &nbsp;投诉起始时间：&nbsp;
        <input id="msgStart" type="text" size="20" class="easyui-datebox condition" onkeydown="if(event.keyCode == 13)admin_searchMsg()" style="width:100px;"/> 
        -
        &nbsp;投诉结束时间：&nbsp;
        <input id="msgEnd" type="text" size="20" class="easyui-datebox condition" onkeydown="if(event.keyCode == 13)admin_searchMsg()" style="width:100px;"/>  

         <a href="javascript:admin_searchMsg()" class="easyui-linkbutton"
        iconCls="icon-search" plain="true">查询</a>
	</div>
	<div id="pp" class="easyui-pagination" data-options="total:2000,pageSize:10" style="background:#efefef;border:1px solid #ccc;"></div> 

    <div id="dlg" class="easyui-dialog" style="width:400px;height:350px;padding:10px 20px"
		rownumbers="true" singleSelect="true" closed="true" buttons="#dlg-buttons">
		
	<div class="ftitle">用户信息</div>
	<hr>
	<form id="fm" method="post" >
		<input name="mid" hidden>
		<div class="fitem">
			<label>发送人编号:</label>
			<input name="userb.bid" class="easyui-validatebox">
		</div>
		<div class="fitem">
			<label>接收人编号:</label>
			<input name="sendto" class="easyui-validatebox">
		</div>
		<div class="fitem">
			<label>短信息内容:</label>
			<input name="mcontent">
		</div>
		<div class="fitem">
			<label>状态码:</label>
			<input name="status" class="easyui-validatebox">
		</div>
	</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-ok" onclick="admin_saveMsg()">保存</a>
		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">关闭</a>
	</div>


  </body>
</html>
