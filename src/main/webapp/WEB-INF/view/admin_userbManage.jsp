<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>admin_userbManager</title>
    
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
    function admin_insertUserb(){
    	$('#dlg').dialog('open').dialog('setTitle','添加用户');
    	$('#fm').form('clear');
    	url = 'user/admin_addUserb';
    }
    
    function admin_updateUser(){
    	
        var row = $('#dg').datagrid('getSelected');
        var selectedRows = $("#dg").datagrid("getSelections");
        if (selectedRows.length == 0) {
            $.messager.alert("系统提示", "请选择要更新的用户！");
            return;
        }
        if (row){
        	$('#dlg').dialog('open').dialog('setTitle','编辑用户');
        	$('#fm').form('load',row);
        	url = 'user/admin_updateUserb';
        }
    }

    function saveUser(){
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
    
    function closeUserDialog() {
        $("#dlg").dialog("close");
        resetValue();
    }

    function admin_deleteUserb() {
        var selectedRows = $("#dg").datagrid("getSelections");
        if (selectedRows.length == 0) {
            $.messager.alert("系统提示", "请选择要删除的用户！");
            return;
        }
        var strIds = [];
        for ( var i = 0; i < selectedRows.length; i++) {
            strIds.push(selectedRows[i].bid);
        }
        var ids = strIds.join(",");
        $.messager.confirm("系统提示", "您确定要删除这<font color=red>"
                + selectedRows.length + "</font>个用户吗？", function(r) {
            if (r) {
            	var jsonStr = {
            		bids : ids	
            	};
            	
            	$.ajax({
            		type : 'GET',
            		contentType : 'application/json',
            		url : 'user/admin_deleteUserb',
            		data : jsonStr,
            		dataType : 'json',
            		success : function(data){
            			if(data.tips=='删除成功'){
            			    $.messager.alert("系统提示", "用户已成功删除！");
                            $("#dg").datagrid("reload");
            			}else{
            				$.messager.alert("系统提示", "用户删除失败，请联系系统管理员！");
            			}
            		},
            		error : function(data){
            			
            		}
            	});
            	
//                 $.post("user/admin_deleteUserb", {
//                     bids : ids
//                 }, function(data) {
//                     if (data.tips=='删除成功') {
//                         $.messager.alert("系统提示", "用户已成功删除！");
//                         $("#dg").datagrid("reload");
//                     } else {
//                         $.messager.alert("系统提示", "用户删除失败，请联系系统管理员！");
//                     }
//                 }, "json");
            }
        });
       }
    
       function admin_searchUserb(){
    	   var name = $('#name').val();
    	   var email = $('#email').val();
    	   var phone = $('#phone').val();
    	   var regStart = $('#regStart').val();
    	   var regEnd = $('#regEnd').val(); 
   		   $('#dg').datagrid('load', {    
  		    name: name,
  		    email : email,
  		    phone : phone,
  		    regStart : regStart,
  		    regEnd : regEnd
  	       });  
    	   
    	   $('#dg').datagrid('reload');
       }
       
       function clearCondition(){
    	   $('.condition').val('');
       }
  </script> 
  </head>
  
  <body>
    <!-- 用户列表框 -->
	<table id="dg" title="用户管理" class="easyui-datagrid" 
			url="user/admin_selectUserbList" method="GET" pagination="true" 
			toolbar="#toolbar" striped="true"
			rownumbers="true" fitColumns="true" singleSelect="1" fit="true">
		<thead>
			<tr>
			    <th field="cb" checkbox="true" align="center"></th>
				<th field="bid" width="20" align="center">编号</th>
				<th field="name" width="50" align="center">账号</th>
				<th field="pass" width="40" align="center">密码</th>
				<th field="img" width="70" align="center">头像</th>
				<th field="email" width="50" align="center">邮箱</th>
				<th field="phone" width="50" align="center">手机号</th>
				<th field="status" width="25" align="center">邮箱状态码</th>
				<th field="registertime" width="50" align="center">注册时间</th>
			    <th field="intro" width="110" align="center">个人介绍</th>
			</tr>
		</thead>
	</table>

	<div id="toolbar">
		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="admin_insertUserb()">添加用户</a>
		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="admin_updateUser()">编辑用户</a>
		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="admin_deleteUserb()">删除用户</a>
        		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-clear" plain="true" onclick="clearCondition()">清除所有条件</a>
        <br>
        &nbsp;账号：&nbsp;<input type="text" id="name" size="20" class="condition"
        onkeydown="if(event.keyCode == 13)admin_searchUserb()" style="width:100px;"/> 
        
        &nbsp;邮箱：&nbsp;<input type="text" id="email" size="20" class="condition"
        onkeydown="if(event.keyCode == 13)admin_searchUserb()" style="width:160px;"/>
        
        &nbsp;手机号：&nbsp;<input type="text" id="phone" size="20" class="condition"
        onkeydown="if(event.keyCode == 13)admin_searchUserb()" style="width:100px;"/>
        
        &nbsp;注册起始时间：&nbsp;
        <input id="regStart" type="text" size="20" class="easyui-datebox condition" onkeydown="if(event.keyCode == 13)admin_searchUserb()" style="width:100px;"/> 
        <!-- <input type="text" id="regStart" size="20"
        onkeydown="if(event.keyCode == 13)searchUserb()" style="width:100px;"/> -->
        -
        &nbsp;注册结束时间：&nbsp;
        <input id="regEnd" type="text" size="20" class="easyui-datebox condition" onkeydown="if(event.keyCode == 13)admin_searchUserb()" style="width:100px;"/>  
<!--         <input type="text" id="regEnd" size="20" -->
<!--         onkeydown="if(event.keyCode == 13)searchUserb()" style="width:100px;"/> -->
         <a href="javascript:admin_searchUserb()" class="easyui-linkbutton"
        iconCls="icon-search" plain="true">查询</a>
	</div>
	<div id="pp" class="easyui-pagination" data-options="total:2000,pageSize:10" style="background:#efefef;border:1px solid #ccc;"></div> 

	<!-- 创建或编辑用户对话框 -->
    <div id="dlg" class="easyui-dialog" style="width:400px;height:350px;padding:10px 20px"
		rownumbers="true" singleSelect="true" closed="true" buttons="#dlg-buttons">
		
	<div class="ftitle">用户信息</div>
	<hr>
	<form id="fm" method="post" >
		<input name="bid" hidden>
		<div class="fitem">
			<label>账号:</label>
			<input name="name" class="easyui-validatebox" required="true">
		</div>
		<div class="fitem">
			<label>密码:</label>
			<input name="pass" class="easyui-validatebox" required="true">
		</div>
		<div class="fitem">
			<label>头像:</label>
			<input name="img">
		</div>
		<div class="fitem">
			<label>邮箱:</label>
			<input name="email" class="easyui-validatebox" validType="email">
		</div>
		<div class="fitem">
			<label>手机号:</label>
			<input name="phone">
		</div>
		<div class="fitem">
			<label>邮箱状态码:</label>
			<input name="status">
		</div>
	    <div class="fitem">
			<label>个人介绍:</label>
			<input name="intro">
		</div>
	</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveUser()">保存</a>
		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">关闭</a>
	</div>
	
	

  </body>
</html>
