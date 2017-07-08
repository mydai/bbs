<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>admin_adminManager</title>
    
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
	
  <style type="text/css">
  .condition{
  }
  </style>	
  <script type="text/javascript" src="resources/easyui/jquery.min.js"></script>   
  <script type="text/javascript" src="resources/easyui/jquery.easyui.min.js"></script> 
    <script type="text/javascript" src="resources/easyui/locale/easyui-lang-zh_CN.js"></script> 
  <script type="text/javascript">
    function admin_insertAdmin(){
    	$('#dlg').dialog('open').dialog('setTitle','添加管理员');
    	$('#fm').form('clear');
    	url = 'admin/admin_insertAdmin';
    }
    
    function admin_updateAdmin(){
    	
        var row = $('#dg').datagrid('getSelected');
        var selectedRows = $("#dg").datagrid("getSelections");
        if (selectedRows.length == 0) {
            $.messager.alert("系统提示", "请选择要更新的管理员！");
            return;
        }
        if (row){
        	$('#dlg').dialog('open').dialog('setTitle','编辑管理员');
        	$('#fm').form('load',row);
        	url = 'admin/admin_updateAdmin';
        }
    }

    function saveAdmin(){
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
    
    function closeAdminDialog() {
        $("#dlg").dialog("close");
        resetValue();
    }

    function admin_deleteAdmin() {
        var selectedRows = $("#dg").datagrid("getSelections");
        if (selectedRows.length == 0) {
            $.messager.alert("系统提示", "请选择要删除的管理员！");
            return;
        }
        var strIds = [];
        for ( var i = 0; i < selectedRows.length; i++) {
            strIds.push(selectedRows[i].aid);
        }
        var ids = strIds.join(",");
        $.messager.confirm("系统提示", "您确定要删除这<font color=red>"
                + selectedRows.length + "</font>个管理员吗？", function(r) {
            if (r) {
            	var jsonStr = {
            		aids : ids	
            	};
            	
            	$.ajax({
            		type : 'GET',
            		contentType : 'application/json',
            		url : 'admin/admin_deleteAdmin',
            		data : jsonStr,
            		dataType : 'json',
            		success : function(data){
            			if(data.tips=='删除成功'){
            			    $.messager.alert("系统提示", "管理员已成功删除！");
                            $("#dg").datagrid("reload");
            			}else{
            				$.messager.alert("系统提示", "管理员删除失败，请联系系统管理员！");
            			}
            		},
            		error : function(data){
            			
            		}
            	});
            }
        });
       }
    
       function admin_searchAdmin(){
    	   var name = $('#name').val();
    	   var email = $('#email').val();
    	   var regStart = $('#regStart').val();
    	   var regEnd = $('#regEnd').val(); 
   		   $('#dg').datagrid('load', {    
  		    name: name,
  		    email : email,
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
	<table id="dg" title="管理员管理" class="easyui-datagrid" 
			url="admin/admin_selectAdminList" method="GET" pagination="true" 
			toolbar="#toolbar" striped="true"
			rownumbers="true" fitColumns="true" singleSelect="1" fit="true">
		<thead>
			<tr>
			    <th field="cb" checkbox="true" align="center"></th>
				<th field="aid" width="20" align="center">编号</th>
				<th field="name" width="50" align="center">账号</th>
				<th field="pass" width="40" align="center">密码</th>
				<th field="email" width="50" align="center">邮箱</th>
				<th field="status" width="25" align="center">邮箱状态码</th>
				<th field="registertime" width="50" align="center">注册时间</th>
			</tr>
		</thead>
	</table>

	<div id="toolbar">
		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="admin_insertAdmin()">添加管理员</a>
		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="admin_updateAdmin()">编辑管理员</a>
		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="admin_deleteAdmin()">删除管理员</a>
		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-clear" plain="true" onclick="clearCondition()">清除所有条件</a>
        <br>
        &nbsp;账号：&nbsp;<input type="text" id="name" size="20" class="condition"
        onkeydown="if(event.keyCode == 13)searchAdmin()" style="width:100px;"/> 
        
        &nbsp;邮箱：&nbsp;<input type="text" id="email" size="20" class="condition"
        onkeydown="if(event.keyCode == 13)searchAdmin()" style="width:160px;"/>
        
        &nbsp;注册起始时间：&nbsp;
        <input id="regStart" type="text" size="20" class="easyui-datebox condition" onkeydown="if(event.keyCode == 13)searchAdmin()" style="width:100px;"/> 
        <!-- <input type="text" id="regStart" size="20"
        onkeydown="if(event.keyCode == 13)searchUserb()" style="width:100px;"/> -->
        -
        &nbsp;注册结束时间：&nbsp;
        <input id="regEnd" type="text" size="20" class="easyui-datebox condition" onkeydown="if(event.keyCode == 13)searchAdmin()" style="width:100px;"/>  
<!--         <input type="text" id="regEnd" size="20" -->
<!--         onkeydown="if(event.keyCode == 13)searchUserb()" style="width:100px;"/> -->
         <a href="javascript:admin_searchAdmin()" class="easyui-linkbutton"
        iconCls="icon-search" plain="true">查询</a>
	</div>
	<div id="pp" class="easyui-pagination" data-options="total:2000,pageSize:10" style="background:#efefef;border:1px solid #ccc;"></div> 

	<!-- 创建或编辑用户对话框 -->
    <div id="dlg" class="easyui-dialog" style="width:400px;height:350px;padding:10px 20px"
		rownumbers="true" singleSelect="true" closed="true" buttons="#dlg-buttons">
		
	<div class="ftitle">管理员信息</div>
	<hr>
	<form id="fm" method="post" >
		<input name="aid" hidden>
		<div class="fitem">
			<label>账号:</label>
			<input name="name" class="easyui-validatebox" required="true">
		</div>
		<div class="fitem">
			<label>密码:</label>
			<input name="pass" class="easyui-validatebox" required="true">
		</div>
		<div class="fitem">
			<label>邮箱:</label>
			<input name="email" class="easyui-validatebox" validType="email">
		</div>
		<div class="fitem">
			<label>邮箱状态码:</label>
			<input name="status">
		</div>
	</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveAdmin()">保存</a>
		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">关闭</a>
	</div>

  </body>
</html>
