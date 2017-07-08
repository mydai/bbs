<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>admin_themeManager</title>
    
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
    function admin_insertTheme(){
    	$('#dlg').dialog('open').dialog('setTitle','添加主题');
    	$('#fm').form('clear');
    	url = 'theme/admin_insertTheme';
    }
    
    function admin_updateTheme(){
    	
        var row = $('#dg').datagrid('getSelected');
        var selectedRows = $("#dg").datagrid("getSelections");
        if (selectedRows.length == 0) {
            $.messager.alert("系统提示", "请选择要更新的主题！");
            return;
        }
        if (row){
        	$('#dlg').dialog('open').dialog('setTitle','编辑主题');
        	$('#fm').form('load',row);
        	url = 'theme/admin_updateTheme';
        }
    }

    function saveTheme(){
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
    
    function closeThemeDialog() {
        $("#dlg").dialog("close");
        resetValue();
    }

    function admin_deleteTheme() {
        var selectedRows = $("#dg").datagrid("getSelections");
        if (selectedRows.length == 0) {
            $.messager.alert("系统提示", "请选择要删除的主题！");
            return;
        }
        var strIds = [];
        for ( var i = 0; i < selectedRows.length; i++) {
            strIds.push(selectedRows[i].tid);
        }
        var ids = strIds.join(",");
        $.messager.confirm("系统提示", "您确定要删除这<font color=red>"
                + selectedRows.length + "</font>个主题吗？", function(r) {
            if (r) {
            	var jsonStr = {
            		tids : ids	
            	};
            	
            	$.ajax({
            		type : 'GET',
            		contentType : 'application/json',
            		url : 'theme/admin_deleteTheme',
            		data : jsonStr,
            		dataType : 'json',
            		success : function(data){
            			if(data.tips=='删除成功'){
            			    $.messager.alert("系统提示", "主题已成功删除！");
                            $("#dg").datagrid("reload");
            			}else{
            				$.messager.alert("系统提示", "主题删除失败，请联系系统管理员！");
            			}
            		},
            		error : function(data){
            			
            		}
            	});
            }
        });
       }
    
       function admin_searchTheme(){
    	   var tname = $('#tname').val();
    	   var createStart = $('#createStart').val();
    	   var createEnd = $('#createEnd').val(); 
   		   $('#dg').datagrid('load', {    
   			tname: tname,
   			createStart : createStart,
   			createEnd : createEnd
  	       });  
    	   
    	   $('#dg').datagrid('reload');
       }
       
       function clearCondition(){
    	   $('.condition').val('');
       }
  </script> 
  </head>
  
  <body>
    <!-- 主题列表框 -->
	<table id="dg" title="主题管理" class="easyui-datagrid" 
			url="theme/admin_selectThemeList" method="GET" pagination="true" 
			toolbar="#toolbar" striped="true"
			rownumbers="true" fitColumns="true" singleSelect="1" fit="true">
		<thead>
			<tr>
			    <th field="cb" checkbox="true" align="center"></th>
				<th field="tid" width="20" align="center">编号</th>
				<th field="tname" width="50" align="center">主题名</th>
				<th field="createtime" width="50" align="center">创建时间</th>
			</tr>
		</thead>
	</table>

	<div id="toolbar">
		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="admin_insertTheme()">添加主题</a>
		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="admin_updateTheme()">编辑主题</a>
		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="admin_deleteTheme()">删除主题</a>
        		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-clear" plain="true" onclick="clearCondition()">清除所有条件</a>
        <br>
        &nbsp;主题名：&nbsp;<input type="text" id="tname" size="20" class="condition"
        onkeydown="if(event.keyCode == 13)admin_searchTheme()" style="width:100px;"/> 
        
        &nbsp;创建起始时间：&nbsp;
        <input id="createStart" type="text" size="20" class="easyui-datebox condition" onkeydown="if(event.keyCode == 13)admin_searchTheme()" style="width:100px;"/> 
        -
        &nbsp;创建结束时间：&nbsp;
        <input id="createEnd" type="text" size="20" class="easyui-datebox condition" onkeydown="if(event.keyCode == 13)admin_searchTheme()" style="width:100px;"/>  
         <a href="javascript:admin_searchTheme()" class="easyui-linkbutton"
        iconCls="icon-search" plain="true">查询</a>
	</div>
	<div id="pp" class="easyui-pagination" data-options="total:2000,pageSize:10" style="background:#efefef;border:1px solid #ccc;"></div> 

	<!-- 创建或编辑用户对话框 -->
    <div id="dlg" class="easyui-dialog" style="width:400px;height:150px;padding:10px 20px"
		rownumbers="true" singleSelect="true" closed="true" buttons="#dlg-buttons">
		
	<div class="ftitle">主题信息</div>
	<hr>
	<form id="fm" method="post" >
		<input name="tid" hidden>
		<div class="fitem">
			<label>主题名:</label>
			<input name="tname" class="easyui-validatebox" required="true">
		</div>
	</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveTheme()">保存</a>
		<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">关闭</a>
	</div>
	
	

  </body>
</html>
